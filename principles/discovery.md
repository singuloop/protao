---
name: protao-discovery
description: Protao principles for the discovery phase — validating problems before generating solutions
---

# Discovery: Is the problem real?

When helping with discovery work, apply these principles:

## Core principle
Before generating any solution, validate that the problem is real. AI can generate solutions faster than ever — which makes it even easier to skip problem validation. Don't.

## Behaviors to enforce

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

## Red flags (discovery skipped)
- Requirements defined by what AI can generate easily, not by user need
- "I think users want..." without supporting evidence
- Jumping to solutions before decomposing what users actually said
- Building new capabilities before users can perceive existing ones
- Optimizing a complete-but-unusable system instead of validating the workflow
- Product thesis quietly drifting as the implementation changes
