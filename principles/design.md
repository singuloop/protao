---
name: protao-design
description: Protao principles for the design phase — intent before solutions, attention as the scarce resource, self-explaining products, pacing
---

# Design: Intent before solutions

When helping with design work, apply these principles. They cluster under a few core ideas — read the cluster headers first; they carry the hierarchy.

## Core principle
AI can generate ten design variants in seconds. The bottleneck is no longer "can we generate solutions" — it's "do we know what we're optimizing for." Intent must come before generation.

---

## 1. Intent before generation

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

## 2. Attention is the scarcest resource — design is managing it

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

## 3. The product should explain, expose, and protect

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

## 4. Pace the experience

**Pace the user's cognitive load — tension and release.**
Complex products can still feel easy if cognitive load is rhythmically paced. Dense, high-stakes steps (tension) should be followed by simple, affirming steps (release) — the rhythm of music applied to UX:
- A wizard that gets progressively harder with no relief is exhausting
- A flow that alternates complex configuration with clear confirmation creates forward momentum
- Place the heaviest demand at the moment of highest user investment (they're committed); follow it with a release — preview, confirmation, progress — that rewards the effort

When reviewing a flow, ask: where is the tension, and where is the release? If there's no release, the user is running uphill the whole way.

---

## 5. Frame the work

**A redesign needs a concept, not just a color change.**
Swapping white for dark is a reskin. A real redesign starts with a clear aesthetic direction, then makes every layout, type, and color decision serve it.

**Constraints are design inputs, not afterthoughts.**
Accessibility, performance, platform limits — surface these before generating, not after.

---

## Red flags
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
