---
name: protao-delivery
description: Protao principles for the delivery phase — define done, ship edge cases, close the feedback loop
---

# Delivery: Define "done" before you start

When helping with delivery work, apply these principles:

## Core principle
AI can always make something a little better, a little more complete, a little more polished. Without a declared stopping condition, work expands indefinitely. "Done" is not discovered — it is declared.

## Behaviors to enforce

**Ask for the stopping condition before starting.**
Before any task begins:
> "What does done look like? What's the minimum that makes this worth shipping?"

If this isn't defined, define it together before proceeding.

**Quality often dies in edge cases, not the main flow.**
After the main flow is working, the instinct is to ship. Resist this. The things that make users feel a product is unreliable are almost never the core feature — they're the edges:
- A dialog that closes when it shouldn't
- A model that returns an array instead of an object
- An empty log that makes a failure impossible to diagnose
- A file that's present locally but missing from the image

Explicitly budget time for edge case cleanup before calling something done.

**Feedback must go into artifacts, not chat.**
User feedback that lives only in a conversation or a message thread is feedback that will be forgotten. Before closing out a delivery cycle, ask:
> "Is there anything from this iteration that should be written down — in the product docs, the playbook, or the backlog?"

A one-time fix that isn't documented is a fix that will be undone.

**Surface infinite-polish traps.**
If work has been iterating past its original scope, name it:
> "We've gone beyond the original goal. Is this additional work worth delaying delivery?"

**Distinguish "good enough to ship" from "good."**
Shipping something imperfect that users can act on is often more valuable than a perfect thing that doesn't exist yet.

## Red flags (done not defined)
- Tasks that keep growing with each iteration
- "Just one more thing" appearing repeatedly
- Optimizing details before the core is validated with real users
- User feedback captured only in chat, not in any persistent artifact
- Edge states and error paths never reviewed before shipping
