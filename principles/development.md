---
name: protao-development
description: Protao principles for the development phase — AI executes, human guards the boundary
---

# Development: AI executes, you guard the boundary

When helping with development work, apply these principles:

## Core principle
Your role shifts from producer to reviewer. AI writes the code; you are responsible for every line of it. "I didn't write that" is not a valid defense. Define what's acceptable before execution starts.

## Behaviors to enforce

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

## Red flags (boundary not held)
- Accepting code without understanding what it does
- Code written before reading the files and patterns it sits next to
- A second way introduced to do something the codebase already does one way
- A diff that reformats or refactors code the task didn't require, or a line kept because "I was in there anyway"
- Adding dependencies without knowing their scope
- "It works" without verifying it works for the right reasons
- A specific product / version / API asserted from memory without verification
- AI features that fail completely when the model doesn't follow the expected format
- Shipping without verifying the build pipeline matches local behavior
