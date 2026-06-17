---
name: protao-architecture
description: Protao principles for system architecture — state machines, job models, data models, migration, and irreversible points
---

# Architecture: Design for the running state, not just the happy path

When helping with backend or system architecture, apply these principles:

## Core principle
The hard part of a system is not creating things — it's keeping the database, ports, external services, and real-world state consistent over time. Architecture decisions must account for failure, recovery, and the running state from the start, not as an afterthought.

## Behaviors to enforce

**Write the point of no return into the design.**
For any operation with external side effects, identify the irreversible point explicitly. Before it: failure can roll back and clean up. After it: failure must go to a repair state, not be treated as a normal failure that gets cleaned up (which would destroy committed work).

- Every external side effect needs a persisted stage — not just in-memory state
- A repair state must block other writes until resolved
- Recovery needs one source of truth (persisted payload + execution journal)
- State names should match operational reality (`repair_required`, `drain_pending`) not generic `running`/`failed`

**Model long or remote operations as jobs, not synchronous RPC.**
Anything that takes more than a few seconds, runs remotely, or can be interrupted by a restart should be a job: control plane creates it, worker claims it, executes, reports back logs/status/result.

- Use claim tokens and claim epochs to prevent stale workers writing new state
- Heartbeats both signal liveness and trigger lease renewal / timeout scans
- For destructive operations, change control-plane state only after the worker reports success
- Prefer worker-pull over requiring inbound management ports on target machines

**Make the data model responsible for the running state.**
- Resource allocation (ports, slots) needs a lease table with states (pending/active/draining) — don't infer from scanning current usage
- After introducing a new dimension (multi-target, multi-tenant), all running-state data must carry that dimension or you get cross-reads
- Separate the active table (current config) from the history table (per-operation payload, logs, stages)
- Schema migrations must default historical rows sensibly, or old data disappears from views after deploy

**Don't bind a big migration to a big rewrite.**
When evolving architecture, let the new path coexist with the old one. Keep a stable fallback. Add the data model for the new dimension rather than overloading naming conventions. Reuse existing state machines for new capabilities rather than inventing fragile new protocols.

**Separate control plane from execution plane.**
State it in one sentence: the control plane decides *what* to do; the worker decides *how* to do it on the target. Don't let workers choose global resources — the control plane allocates, the worker reports conflicts and requests reallocation.

**Define non-goals explicitly.**
Write down what the system will NOT do, and why. This prevents scope drift and repeated re-litigation of the same boundary decisions in later sessions.

**Design for the system's breathing rhythm.**
Traffic has peaks and valleys. A system that can only handle average load will panic at peaks and waste at valleys. Design explicitly for both:

- **Absorb bursts**: message queues and async processing decouple the arrival rate from the processing rate — the system breathes in without choking
- **Recover in quiet windows**: GC, TTL cleanup, index maintenance, and scheduled jobs run when load is low — the system exhales and resets
- **Protect against cascade**: rate limiting and circuit breakers prevent a degraded component from dragging down everything connected to it

Graceful degradation is the system's force balance under stress. The test of a well-designed system isn't its behavior at normal load — it's what shape it holds when one component degrades.

**Separate what must be stable (律) from what must evolve (韵).**
Every system has two layers that must be kept distinct:

- **律 (stable foundation)**: API contracts, data schemas, inter-service interfaces, base component behavior. These are commitments. Changing them requires explicit migration and coordination. They exist precisely because other things depend on them.
- **韵 (flexible expression)**: business rules, UI variations, feature-specific behavior, micro-interactions. These live above the stable layer and can change freely *because* they don't touch it.

The failure mode is mixing the layers: business logic baked into a schema, or a schema changed casually for one feature. When this happens, the foundation becomes unreliable and the evolution becomes constrained — you lose both properties at once.

Name these layers explicitly. When someone proposes a change, the first question is: are we changing 律 or 韵? The answer determines the cost and the process.

## Red flags (running state not designed)
- External side effects with no persisted stage
- Failure after the point of no return treated like any other failure
- Long/remote operations as synchronous blocking calls
- Running-state data that can't distinguish current from historical, or lacks a needed dimension
- A migration that requires rewriting the stable path at the same time
- No written record of what the system deliberately doesn't do
