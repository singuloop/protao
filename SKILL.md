---
name: protao
description: Product development philosophy for the AI age. Applies when the task involves discovery, design, architecture, development, AI features, AI generation, testing, or delivery — any decision where human judgment should be preserved over disposable technique. Distilled judgments that survive model generations. Triggers — building a new feature/product, designing UI or a system, choosing an approach, reviewing code or UX, deciding when to use AI, defining what "done" means, or any moment that calls for a judgment a stronger model wouldn't make for you.
---

# Protao — Product development philosophy for the AI age

When "execution" becomes infinitely cheap, judgment becomes the scarce resource. AI takes over **technique** (the learnable, tool-able execution); it does not take over **judgment** (knowing what's worth doing, what "good" means, where the line is). Protao is a set of judgments — across the full product lifecycle — that a human should keep hold of, because a stronger model won't make them for you.

**First principle:** if an insight stops being true when you swap in a stronger model, it's technique, not worth following here. What's below is the judgment that survives.

Apply the relevant section to the task at hand. Each section ends with red flags — signals that the judgment is being violated.

---


## Discovery: Is the problem real?

When helping with discovery work, apply these principles:

### Core principle
Before generating any solution, validate that the problem is real. AI can generate solutions faster than ever — which makes it even easier to skip problem validation. Don't.

### Behaviors to enforce

**Hold the product thesis; let the implementation change.**
A product needs one sentence that guides trade-offs — e.g., "the user wants a framed, curated result, not control over every pixel." When the implementation changes (grid → freeform → AI generation), what changes is the path, not the thesis. Before any big change, ask:
> "Does this strengthen the core experience, or just the completeness of the system?"

Let technical approaches change. Don't let the product thesis drift.

**A complete system is not the same as a usable one.**
The more complete an internal abstraction, the easier it is to believe "we've solved it." But a well-structured system that users find hard to use has not solved the problem. If a solution needs a lot of teaching before anyone can use it, it's probably not the MVP mainline. Validate with real users' tasks before perfecting the system's expressive power.

**Decompose user feedback before acting on it.**
When a user says "information isn't enough," "can't find the entry," or "the copy is too complex," these are symptoms, not requirements. Before proposing solutions, ask:
> "What is the user actually failing to do? What do they not understand, not trust, or not control?"

Map the symptom to the underlying gap first. Then decide what to build.

**Make existing capabilities visible before building new ones.**
Before adding new features, ask: does the user know what the system can already do? Often the first step is reorganizing and surfacing what exists — not adding more.

**Distinguish interesting from urgent.**
Interesting problems are worth exploring. Urgent problems are worth building for. They are not the same.

**Look for existing signals.**
Before treating a problem as new: has anyone tried to solve this before? What happened? What does that reveal?

### Red flags (discovery skipped)
- Requirements defined by what AI can generate easily, not by user need
- "I think users want..." without supporting evidence
- Jumping to solutions before decomposing what users actually said
- Building new capabilities before users can perceive existing ones
- Optimizing a complete-but-unusable system instead of validating the workflow
- Product thesis quietly drifting as the implementation changes

---


## Design: Intent before solutions

When helping with design work, apply these principles. They cluster under a few core ideas — read the cluster headers first; they carry the hierarchy.

### Core principle
AI can generate ten design variants in seconds. The bottleneck is no longer "can we generate solutions" — it's "do we know what we're optimizing for." Intent must come before generation.

---

### 1. Intent before generation

**Require intent before generating.**
Before producing any design, ensure the user can state:
- What is the user trying to accomplish?
- Where are they currently blocked?
- What does success look like?

If these are unclear, ask — don't generate.

**Define the page's role before adding features.**
Every page or module should have one primary job. Before adding anything, ask: what is this page for? If a control doesn't serve that primary job, it doesn't belong here — regardless of whether the data exists in the database. Common traps: legacy fields from an older design, controls that made sense in a different context, database columns that exist but shouldn't be user-visible.

**Grow the design from existing context — don't design from a blank canvas.**
High-fidelity design invented from nothing is almost always generic. Before designing, find the context it should grow from: an existing design system, a codebase, a shipped product, brand assets, a reference the user admires. When a codebase exists, read the actual values — hex codes, spacing scale, font stack, radii — and use them exactly. Don't repaint from memory.

A project's design ceiling is set by the quality of context you gather before starting. Ten minutes collecting context beats an hour inventing hi-fi from intuition. When there's genuinely no context, say so plainly and ask for some — designing blind is the last resort, not the default.

**Organize flows by user intent, not system capability.**
Users think "where do I want to change this" before "how do I change it." UI should string together an operation path, not display a menu of system capabilities. When an operation depends on a selection (range, target, scope), the preview area must show spatial feedback — the user needs to see what they've selected before acting on it.

**Passive loading must never cause navigation. Navigation requires explicit user action.**
When a page initializes — fetching data, checking auth state, resolving user identity — those are things the *system* is doing, not things the *user* asked for. A user who opens a page has not asked to be redirected. If those initialization actions trigger navigation (redirect to login, bounce to error page), the system is making a decision the user didn't make.

The separation: loading/initialization degrades gracefully into empty states or prompts; navigation only fires when the user takes a deliberate action (clicks login, submits a form, follows a link). This protects user agency and makes behavior predictable — opening a page should never surprise you with a destination you didn't choose.

---

### 2. Attention is the scarcest resource — design is managing it

Every element on a screen spends some of the user's attention. The job of design is not to display everything the system knows; it's to spend the user's attention on what matters and protect it from everything else. The rules below all descend from this.

**Speak the user's language, hide the system's complexity.**
The user should not have to understand how the system works to use it. Internal names (`snapshot`, `data_tasks`, `HTML`, `Patch`, `visual audit`) must never appear in UI — translate to what the user cares about. Keep implementation detail in logs and backends; surface only what the user needs to act. For status, "正在检查页面布局" not "visual audit running."

**Don't express the same thing twice.**
If something is already expressed through visual structure — state, hierarchy, position, color — don't repeat it in text. And when text is necessary, say it once, plainly: don't use two semantically-overlapping phrases where one does the job. Redundant expression is noise that costs attention for no gain. (Brevity here isn't about word count — it's about not making the user parse the same meaning twice.)

**Visual weight must be intentional.**
A screen where everything has equal weight has no hierarchy, and a screen with no hierarchy gives the user nowhere to look first. Use size, color, spacing, and position to create rhythm — what's primary, what's secondary, what's ambient. The user should *feel* where their eye is meant to go without being told.

**Never let a single channel carry information alone.**
If meaning rides on color alone — red means error, green means done — anyone who can't distinguish those colors loses the meaning entirely. The same trap applies to any single channel: position alone, icon shape alone, sound alone. Encode important meaning redundantly: color *and* an icon, *and* a label. This isn't only an accessibility checkbox — redundant encoding makes meaning more robust for everyone, in bright sunlight, on a bad screen, while glancing. The principle outlives any specific guideline: the more important the signal, the more independent the cues that should carry it.

**Semantic signals must have visual dominance, not just semantic color.**
Calling a color "error red" or "success green" means nothing if it only tints some text while the container stays neutral gray. The signal's visual weight must match its importance. A status that matters — error, warning, active, selected — needs a spatial anchor: a colored border, a background tint, a badge, a top strip. If a user scanning the page can't read the state at a glance without stopping to read the label color, the semantic signal has been reduced to decoration. Ask: can someone understand the state in one second without reading?

**Subtract, don't add.**
When a design feels cluttered, the fix is almost always removal: merge redundant controls, remove non-essential explanatory text, move operations closer to where attention already is, let structure carry what text is trying to say. Each control must justify its existence — not just by its visual space, but by the cost of the user having to understand it. If the system can decide automatically, don't make the user decide. The instinct "this would look better with one more thing added" is usually a warning sign, not an insight — default to the simplest version; add only when something is genuinely missing, not to fill space.

**Craft is uneven by design — 120% in one place, 80% elsewhere.**
Taste is not spreading effort evenly across everything. It's making one detail exceptional — the thing worth a screenshot — and letting the rest be merely solid. A design where everything is equally polished reads as flat; one with a single signature moment and a calm supporting cast reads as intentional. Decide where the 120% goes, and protect the 80% from creeping up into noise.

> A good interface feels calm not because it has little on it, but because everything on it earns its place.

---

### 3. The product should explain, expose, and protect

**A good product teaches itself through use.**
The hierarchy of how users learn a product:
1. **Interaction flow first** — the sequence of screens and actions makes the next step obvious without explanation
2. **Contextual hints second** — labels, tooltips, placeholders for genuinely non-obvious moments
3. **Documentation last** — a fallback for edge cases and power users, never the primary path

If users need a manual to complete a core task, that's a design failure, not a documentation gap. When something is hard to understand, the default instinct should be to simplify the flow — not to better explain the complex one.

**Key information must be transparent to users.**
Users should know what the system is doing with things that affect them: what data was read, what produced a result, what changed, what failed and why. Hiding this to appear simpler often backfires — users distrust what they can't see. Scope it: surface what helps users act or builds justified trust; don't surface implementation details that only add noise.

**Privacy must be a design constraint, not an afterthought.**
Sensitive information — balances, tokens, personal data, user-owned content — must be protected at both layers:
- **UI layer**: sensitive values hidden by default, revealed only on deliberate action; tokens always masked (head and tail only)
- **Backend layer**: store only what's necessary; enforce access ownership at the API level; admin access explicit, not inherited

The UI hiding something is not a substitute for the backend enforcing it. Both must hold independently.

---

### 4. Pace the experience

**Pace the user's cognitive load — tension and release.**
Complex products can still feel easy if cognitive load is rhythmically paced. Dense, high-stakes steps (tension) should be followed by simple, affirming steps (release) — the rhythm of music applied to UX:
- A wizard that gets progressively harder with no relief is exhausting
- A flow that alternates complex configuration with clear confirmation creates forward momentum
- Place the heaviest demand at the moment of highest user investment (they're committed); follow it with a release — preview, confirmation, progress — that rewards the effort

When reviewing a flow, ask: where is the tension, and where is the release? If there's no release, the user is running uphill the whole way.

---

### 5. Frame the work

**A redesign needs a concept, not just a color change.**
Swapping white for dark is a reskin. A real redesign starts with a clear aesthetic direction, then makes every layout, type, and color decision serve it.

**Constraints are design inputs, not afterthoughts.**
Accessibility, performance, platform limits — surface these before generating, not after.

---

### Red flags
- "Make it look good" with no further direction
- Controls on a page that don't serve its primary role
- Designing hi-fi from a blank canvas when real context (codebase, design system, references) was available
- Repainting values from memory instead of reading the actual codebase
- UI using internal field names, debug vocabulary, or technical state names
- User has to understand system implementation to complete a task
- The same information expressed both visually and in text
- Two overlapping phrases where one plain sentence would do
- A screen where everything has equal visual weight — no hierarchy, nowhere to look first
- Meaning carried by color (or any single channel) alone, with no redundant cue
- A status that matters (error, warning, active) only tints text — no spatial anchor, unreadable at a glance
- Page initialization triggers navigation without any user action
- "This would look better with one more thing" used to justify adding, not removing
- Effort spread evenly with no signature detail — polished but flat
- Users need to read documentation to complete a core task
- The system takes consequential actions without the user knowing (what was read, what changed, why)
- Sensitive values visible by default in the UI, or backend access control relying on UI hiding
- Generating variants before agreeing on what we're solving for

---


## Simplicity: Nothing left to remove

When helping with architecture, code design, or system decisions, apply these principles.

### Core principle
Complexity is not sophistication. A system is simple not when there is nothing more to add, but when there is nothing left to remove while still fully serving its purpose. The burden of proof always falls on the complex solution, not the simple one.

This is Occam's Razor applied to engineering — and it is a form of discipline, not laziness. The simplest correct path is often harder to find than an elaborate one.

### Behaviors to enforce

**Apply Occam's Razor at every decision point.**
Before introducing a new abstraction, service, or dependency, ask: does the simpler alternative fully solve the problem?
- 3 lines of code before 30
- A simple queue before a distributed cluster
- A direct call before an event bus, unless indirection is genuinely warranted
- A single process before microservices

When both paths work, the simpler one is better — it's cheaper to understand, cheaper to change, and cheaper to debug. This applies regardless of how technically interesting the complex path is.

**Treat module boundaries as composition.**
A module's boundary clarity is its architecture. Single Responsibility is the minimalism of system design: a module that does one thing, does it completely, and asks for exactly what it needs — no more.

- **Cohesion**: the parts inside a module belong together. If you have to explain why several things are in the same module, they probably aren't.
- **Coupling**: the module depends on exactly what it needs. If removing a dependency requires rewriting the module, the dependency wasn't optional — it was baked in.

Both degrade over time without deliberate attention. Tune both.

**Write code as a readable score.**
Code is read far more than it is written. A function should say what it does in its name. A file should say what it contains in its structure. Layers should go where they semantically belong.

- Obvious code that does exactly what it says > clever code that requires decoding
- Determinism over surprise: a reader should never have to wonder what a piece of code will do
- Refactoring is noise reduction: "bad smells" (long methods, mystery names, tangled concerns, duplicated logic) are noise in the score — they make the next reader misread the intent

When code needs a comment to explain *what* it does, the code should be renamed or restructured. Comments explain *why*, not *what*.

### Red flags (unnecessary complexity)
- "Let's add a message queue / cache / abstraction layer just in case"
- A dependency added for something the language or standard library already does, or added without a stated reason — it's permanent code you don't control
- A module that has knowledge of many other modules
- Naming that requires reading the implementation to understand
- An abstraction layer that doesn't simplify the caller's code
- The complex solution chosen because it's more interesting to build
- A comment that explains what the code does (instead of why)
- Passing a code review despite no one being able to explain the simplest version of what it does

---


## Architecture: Design for the running state, not just the happy path

When helping with backend or system architecture, apply these principles:

### Core principle
The hard part of a system is not creating things — it's keeping the database, ports, external services, and real-world state consistent over time. Architecture decisions must account for failure, recovery, and the running state from the start, not as an afterthought.

### Behaviors to enforce

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

### Red flags (running state not designed)
- External side effects with no persisted stage
- Failure after the point of no return treated like any other failure
- Long/remote operations as synchronous blocking calls
- Running-state data that can't distinguish current from historical, or lacks a needed dimension
- A migration that requires rewriting the stable path at the same time
- No written record of what the system deliberately doesn't do

---


## Development: AI executes, you guard the boundary

When helping with development work, apply these principles:

### Core principle
Your role shifts from producer to reviewer. AI writes the code; you are responsible for every line of it. "I didn't write that" is not a valid defense. Define what's acceptable before execution starts.

### Behaviors to enforce

**Verify facts before acting on assumptions — this outranks everything else.**
AI states what it "remembers" with the same fluent confidence whether the memory is correct, outdated, or invented. Being responsible for the output includes being responsible for the facts it rests on.

When a task depends on a specific factual claim — does this product/version/API exist, what are its actual parameters, what does this library's current interface look like, did this event happen — verify it against a real source before building on it. Do not assert from training memory.

This even outranks asking clarifying questions: a clarifying question built on a wrong fact is already crooked. Get the facts straight first, then ask.

Watch for your own tells — "I think it's...", "it should be...", "as far as I recall...", "that probably doesn't exist yet." Each is a signal to stop and check, not to assert. The cost asymmetry is decisive: verifying takes seconds; building on a wrong assumption costs hours of rework.

**Read and conform to the codebase before you write.**
The fastest way to produce code that has to be rewritten is to write it before reading what's already there. Read the files you're about to touch, and copy the patterns that already exist — the error-handling shape, the naming, the way data flows. Don't introduce a second way to do something the codebase already does one way (a second HTTP client, a second date library, a parallel config system); consistency outranks your preferred idiom. When there's no pattern to follow, that's a question to ask, not a gap to fill with a plausible guess.

**Make the diff as small as the task allows.**
A change should touch what the task requires and nothing else. Don't fix unrelated things "while you're in there," don't restyle code you happened to open, and never bundle a reformat with a logic change — a formatter pass buries the three lines that matter inside three hundred that don't. The test is whether you can justify every changed line by the task; if a line changed only because you were passing through, revert it. Small diffs are what make review — human or model — actually possible.

**Surface constraints before writing code.**
Before starting, confirm:
- Are there performance boundaries this must stay within?
- Are there security or data handling requirements?
- What technical debt limits apply?

If constraints aren't defined, ask — don't assume none exist.

**For AI features: code controls boundaries, model handles intent.**
Don't hardcode business logic to interpret model output (e.g., keyword matching to guess user intent). Instead:
- Let the model plan what context it needs
- Have the backend enforce what data is allowed, how much, and how to degrade
- Require structured output so downstream code can process it reliably
- Log every model decision for debugging and replay

Keyword rules break when users phrase things differently. Controlled context loaders don't.

**Local running is not the same as production-ready.**
Any feature that depends on files, templates, rules, or assets on the filesystem must be verified end-to-end:
1. Does the file exist at the expected path locally?
2. Is it included in the Docker build context?
3. Is it excluded by `.dockerignore`?
4. Does the container path match the runtime code?

"It works on my machine" is not a ship signal.

**Make stopping conditions explicit.**
Before implementing anything, confirm: what does "done" look like for this task? Unbounded tasks expand indefinitely.

**Engineering discipline is non-negotiable.**
- Run `tsc --noEmit` and build checks before committing
- Delete dead code alongside the feature it served (imports, CSS, files, env vars)
- Treat `cancelled` requests from deduplication as expected, not errors — silence them in catch
- Fix deprecated API warnings before they accumulate

### Red flags (boundary not held)
- Accepting code without understanding what it does
- Code written before reading the files and patterns it sits next to
- A second way introduced to do something the codebase already does one way
- A diff that reformats or refactors code the task didn't require, or a line kept because "I was in there anyway"
- Adding dependencies without knowing their scope
- "It works" without verifying it works for the right reasons
- A specific product / version / API asserted from memory without verification
- AI features that fail completely when the model doesn't follow the expected format
- Shipping without verifying the build pipeline matches local behavior

---


## AI Product Design: A generation is not a product

When helping design or build AI-powered features, apply these principles:

### Core principle
Calling a model once is not a product. The core of an AI generation feature is building a reliable pipeline around unstable output. That pipeline includes: task tracking, phased execution, structured storage, automatic quality checks, user-editable results, and the ability to recover from failure at any point.

### Behaviors to enforce

**Task-ify anything that takes more than a few seconds.**
If generation time exceeds a few seconds, it must be modeled as a background task. Minimum task record fields:
- Task ID, user ID, business object ID
- Status and current stage
- Start time, end time, duration
- Token cost or compute cost
- Error detail (type, message, context)
- Result snapshot

Task stages should be stable internal identifiers — never use them directly as user-facing copy.

**Long tasks must support idempotent recovery.**
A page refresh or service restart should not lose the task. The user must be able to return to a task in progress. Design for this from the start: save a placeholder before generation begins, resume from the last completed stage on reconnect.

**Build quality checks into the pipeline, not as afterthoughts.**
Automatic checks (layout validation, format verification, content review) belong in the generation pipeline as quality gates — not in a separate debug tool or a post-launch feedback loop.

For visual outputs: string-level checks are insufficient. The output must be rendered into a real browser and inspected as a screenshot. Repair must be followed by a second-pass verification — don't trust the repair model's self-report.

**Every key path needs a fallback.**
For each step that depends on model output, define what happens when the model doesn't cooperate:
- Model doesn't call the tool → backend uses local retrieval result
- Model returns array instead of object → normalize before using
- Model times out → degrade gracefully, tell the user, don't block the main flow

Fallbacks are designed behavior for the non-ideal case, not error handling.

**Backend prepares context; model organizes expression.**
Don't rely on the model to retrieve data via tool calls. More reliable pattern:
1. Backend performs local retrieval first
2. Relevant content is injected directly into the prompt
3. Tool calls are enhancement, not the primary path

**Rules filter first; AI explains last.**
When AI processes a stream of signals (error diagnosis, alert triage, classification), don't make AI the first filter. Use deterministic rules for the noisy front: keyword filtering, log levels, stack merging, fingerprint normalization. Let AI be the last layer — explaining and judging what survived the rules, not triaging the raw firehose. Rules-then-AI is more reliable and cheaper than feeding everything to AI.

**A memory system beats one-shot summaries.**
For recurring AI judgments, persist the history: signal fingerprints, past diagnoses, human feedback. Next time a known signal appears, act on accumulated memory instead of bothering a human again. Human feedback (confirmed / false alarm / needs more info) is part of the product loop, not an optional button.

**Open AI entry points only after the underlying foundation is stable.**
An AI or natural-language interface amplifies the uncertainty of whatever it sits on. If the underlying API, logs, and metrics aren't stable, users misread that instability as the AI being unreliable. Sequence AI features after the foundation they depend on.

**Require structured output; normalize everything.**
Define the expected schema. Normalize every variant before using model output downstream. Never assume the model returns the same format twice in a row. AI judgments should carry severity, category, impact, suggested action, and whether to notify.

**Build the admin backend early.**
Once AI tasks are live, without an admin view you're debugging blind. A minimal backend needs: task list with filters, task detail with stage/error/duration/token, user and business object reference. It doesn't need to be beautiful — it needs to be accurate.

**Make degradation visible but non-blocking.**
When the system falls back, the user should know — but the main flow must not be blocked.

**Every AI path needs diagnostic logs.**
Each log entry on an AI path should answer:
- Which model was used
- Which branch was taken (tool call / direct answer / fallback)
- What error occurred (timeout, format, import, empty result)
- Key parameters and task ID

An empty log entry like `"AI fallback:"` has zero debugging value.

**Separate human auth from system auth.**
External tools (CLI, agents) can't use browser SSO. Provide short-lived tokens for external tool use. Keep service-to-service calls on a separate service token. Config names must be explicit.

### Red flags (pipeline missing)
- No background task — generation is a blocking request
- Page refresh loses in-progress work
- Quality checks happen only after user complaints
- Admin can only debug via raw logs
- AI features that fail completely when model skips tool call
- Visual output validated only by string matching
- "The model will handle it" used to justify missing backend guardrails

---


## AI Generation: Build a pipeline, structure the output, own the platform layer

When helping build products where AI generates a substantial artifact (a page, document, design, layout), apply these principles. This complements `protao-ai-product` (which covers task infrastructure and fallbacks) with the generation-specific craft.

### Core principle
One-shot generation of a whole artifact is fragile and unexplainable. Break generation into phases, each solving one problem, each carrying the previous step's summary forward. The platform owns the stable baseline; the model owns the variation.

### Behaviors to enforce

**Generate in phases, not one shot.**
Decompose generation into stages where each does one job: perceive the input → structure the narrative → write content → set direction → render. Each stage:
- Saves its intermediate artifact (for preview, recovery, continued generation)
- Carries forward the prior stage's summary / design memory, so regeneration isn't a fresh dice roll

Make partial regeneration a first-class capability. "Redo the whole thing" must not be the only correction path.

**Treat prompts as maintained product assets, not throwaway strings.**
A one-line stylistic wish ("express through space, rhythm, scale") does not produce stable results. Build a skill library instead:
- Each style/skill defines: when to use, when to avoid, composition moves, anti-patterns
- Anti-patterns matter as much as positive requirements (e.g., "no generic card / dashboard / tech-demo")
- Let the model choose a direction first, then generate — this makes output explainable and tunable

Prompts scattered as long strings in code are a liability. A skill library is an asset.

**An honest placeholder beats a clumsy real attempt.**
When the model lacks the real material — a real image, real data, a real fact — do not have it fabricate something that merely looks real. A labeled placeholder ("[chart — awaiting real data]") is worth far more than invented numbers or a crude generated stand-in, because it tells the truth about what's missing instead of hiding it.

Fabricated filler is worse than a gap: it looks finished, so no one goes back to fix it, and it quietly corrupts trust in everything around it. Mark the gap honestly, surface it at delivery, and let real material replace it later.

**Design artifacts for both full replay and partial editing.**
Don't save just one big output string. Save:
- A stable snapshot (for publishing and replay)
- Structured fragments (for partial regeneration)
- A renderer version (so future upgrades don't break old artifacts)
- Section identity (id, role, source references) for locating, regenerating, and rolling back

Single-file snapshots can't be edited incrementally; pure fragments can't be safely replayed. You need both.

**The platform layer owns stability; the model owns expression.**
Don't make the model responsible for motion, accessibility, responsive fallbacks, or security every time. Inject these in the platform layer; the model only preserves hooks (`data-section`, `data-motion`, body classes). This gives every generated result a consistent minimum quality. Prompt the model explicitly to never delete platform hooks.

**Define safety boundaries before allowing HTML/CSS generation.**
The moment a model can generate markup, you need runtime isolation, not just prompt instructions:
- Server-side sanitize of HTML, CSS, and fragments
- Render inside a sandboxed iframe (`sandbox`, `no-referrer`)
- Block external scripts, forms, navigation, fixed overlays, unknown resource loads
- CSS sanitizer must handle `@import`, `javascript:`, dangerous URLs
- Preview and publish must use the same render path — no "safe in editor, unsafe when published"

**Fallback is a shock absorber, not a failure.**
When you shift the main approach, keep the old one as fallback so existing data and drafts still work — but don't let the fallback keep occupying the product's mental mainline. Mark clearly what's mainline vs. fallback; route new data to the new path; document the fallback's purpose so future work doesn't mistake it for the focus.

### Red flags (generation not productized)
- Whole artifact generated in one model call
- Style requirements as a single sentence rather than a structured skill
- Output saved as one string with no fragments or version
- Model responsible for motion/security/responsive every generation
- HTML/CSS generation with no sanitizer or sandbox
- Old approach left ambiguous as to whether it's still the focus

---


## Testing: Verify intent, not just implementation

When helping with testing work, apply these principles:

### Core principle
AI can write tests that achieve 100% pass rate while missing the point entirely. Tests that only verify implementation correctness are insufficient. The test must trace back to what the user actually needs.

### Behaviors to enforce

**Define "correct" before writing tests.**
Before generating any test, ask:
> "If this feature breaks, what would a user notice?"

That answer is what needs to be tested. Start there.

**When something breaks, reproduce it before you change anything.**
Investigate, don't guess: read the whole error and stack trace, reproduce the failure, and change one thing at a time. When you fix a bug, write the test that fails because of it *first*, and watch it fail — that failure is the only proof you found the actual cause and not just something near it. Then fix, and watch it pass. Skipping this is how you "fix" a symptom while the real bug moves somewhere quieter: papering over an unexpected null with a null check never answers why it was null. Test behavior that can actually break, not that a constructor sets a field.

**Hard to test is a fact about the design, not permission to skip.**
When something is difficult to test, that difficulty is information: usually the code is doing too much, its dependencies are tangled, or its intent isn't separable from its wiring. The response is to treat it as a design signal — simplify, decouple, clarify — not to conclude the thing can't be tested and move on.

**For visual outputs: render, don't just parse.**
String-level checks on HTML or generated content are not sufficient. If the product's output is visual — a page, a report, a generated layout — the test input must be a screenshot of the rendered result, not the source string.

Automatic review must cover multiple viewports. Repair must be followed by a second-pass verification — the repair model's self-reported success is not confirmation.

**Verification is the second pair of eyes — always run it.**
AI-written code frequently passes a static read but fails in motion: it looks right in a screenshot but breaks on scroll, works on wide screens but collapses on narrow, renders fine but the interaction is dead, forgets the dark-mode case. The model that wrote it cannot reliably catch these — it already believes the code is correct.

So actually run it: open it, click through the real path, exercise the states. The last minute of verification saves an hour of rework. "Looks correct" is a hypothesis; "I ran it and watched it behave" is a verification. Only the second one is a ship signal.

**Cover edge states explicitly.**
Main-flow tests are necessary but not sufficient. Require tests for:
- Empty state (no data yet)
- First version vs. subsequent versions (behavior often differs)
- Failure state (what does the user see when something goes wrong?)
- Permission boundaries (regular user vs. admin)
- States that only exist after a sequence of actions

The worst user experiences come from edge states that were never tested.

**Shipping is a repeatable process, not a one-time event.**
Before any deployment, run through:
- Automated tests pass
- Type/compile checks clean
- Working directory clean — no local data, logs, temp files
- No tokens or secrets in the commit
- Deployment package dry-run confirms what's included
- Post-deploy: health check hits, public endpoint responds, platform logs clean

This checklist should be written down and reused — not reconstructed each time.

**Distinguish implementation tests from intent tests.**
- Implementation test: "does this function return the expected value?"
- Intent test: "does the user get what they came for?"

Both matter. Intent tests must exist.

### Red flags (intent not tested)
- Test suite passes but no one can explain what breaks if requirements change
- A bug fixed without a test that fails before the fix and passes after
- A symptom papered over (a null check, a try/catch) without finding why it happened
- Tests written after the code, shaped to match what already exists
- Coverage metrics used as a proxy for test quality
- Visual output validated only by string matching
- Code shipped on "looks correct" without anyone running it and watching it behave
- No test for empty, error, or first-time states
- "Deploy and verify" treated as optional

---


## Delivery: Define "done" before you start

When helping with delivery work, apply these principles:

### Core principle
AI can always make something a little better, a little more complete, a little more polished. Without a declared stopping condition, work expands indefinitely. "Done" is not discovered — it is declared.

### Behaviors to enforce

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

### Red flags (done not defined)
- Tasks that keep growing with each iteration
- "Just one more thing" appearing repeatedly
- Optimizing details before the core is validated with real users
- User feedback captured only in chat, not in any persistent artifact
- Edge states and error paths never reviewed before shipping

---


## Evolution: Shipping is the middle, not the end

When helping change, extend, or maintain a product that is already live, apply these principles:

### Core principle
A shipped product is a living commitment, not a finished artifact. Most of its life happens after v1. AI makes every change cheap, and that quietly inverts the risk: the scarce judgment is no longer "can we build this change" but "should this change, and what must survive it." Cheap execution makes churn easy; only human judgment decides what is worth disturbing.

### Behaviors to enforce

**Cheap change raises the bar on "why," it does not lower it.**
When AI can rewrite a module in minutes, the temptation is to keep churning because you can. But every change has a cost the model never sees: users relearn, habits break, and each edit is a fresh chance to regress. Before making a change, ask what it's worth to the user — not whether it's easy to do. "Easy to change" is not a reason to change.

**Separate what users depend on from what is merely incidental.**
A live product accumulates things people rely on: URLs, saved data, keyboard habits, integration contracts, the shape of an output they've built a workflow around. These are commitments, even when they were never written down. Incidental details — internal structure, wording, layout — can move freely. Before changing anything user-facing, ask: is this something someone out there has already built on? Preserve the contract; evolve the expression.

**Patch vs. rewrite is a judgment, not a reflex.**
AI makes "just rewrite it" the cheap default, but a rewrite silently discards the accumulated edge-case knowledge baked into the current code — the quiet fixes for cases no one remembers anymore. Rewrite when the underlying model is wrong; patch when the model is right and only the code is messy. Prefer the patch unless you can name what's fundamentally wrong with the existing design.

**Treat existing behavior as a spec before you change it.**
Regression is the default failure mode of cheap edits: AI changes code without knowing which current behaviors were load-bearing. The bug you fix and the feature you break can be the same edit. Before changing anything with users, capture what must still hold afterward — then verify it still holds. The old behavior is an unwritten spec until proven otherwise.

**Retiring is a first-class activity, not an afterthought.**
AI adds faster than anyone removes. Features, options, flags, and code paths pile up, and each one is weight the next change has to carry. Deciding what to remove is as much a part of evolution as deciding what to add. A product that only ever grows is a product decaying in slow motion.

**Finish the change — two live paths is how systems rot.**
Cheap migration makes it easy to add the new path and leave the old one running "just in case." Two live paths for the same job is not safety; it's ambiguity that compounds. Finish it: route new work to the new path and retire the old one, or mark explicitly which is the mainline and which is the fallback, and why.

**You own what you change, even if you didn't write it.**
Changing code that AI wrote — or that a past version of you wrote — does not transfer responsibility for what it breaks. "I only touched one line" is not a defense when that line was load-bearing. The person making the change owns its consequences.

### Red flags (evolution mishandled)
- Changing something because it's easy, not because it's worth it
- A user-facing contract (URL, data shape, saved state, integration) broken without anyone noticing it was a contract
- Reaching for a rewrite when a patch would do, discarding edge-case knowledge in the process
- A change shipped without capturing which existing behaviors had to keep working
- Features and flags only ever added, never retired
- A migration that leaves two live paths with no declared mainline
- "AI wrote it" or "I only changed one line" used to dodge responsibility for a regression

---

