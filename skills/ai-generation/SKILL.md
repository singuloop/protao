---
name: protao-ai-generation
description: Protao principles for AI generation products — phased pipelines, prompts as assets, snapshot+fragment artifacts, platform layer, sandboxing
---

# AI Generation: Build a pipeline, structure the output, own the platform layer

When helping build products where AI generates a substantial artifact (a page, document, design, layout), apply these principles. This complements `protao-ai-product` (which covers task infrastructure and fallbacks) with the generation-specific craft.

## Core principle
One-shot generation of a whole artifact is fragile and unexplainable. Break generation into phases, each solving one problem, each carrying the previous step's summary forward. The platform owns the stable baseline; the model owns the variation.

## Behaviors to enforce

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

## Red flags (generation not productized)
- Whole artifact generated in one model call
- Style requirements as a single sentence rather than a structured skill
- Output saved as one string with no fragments or version
- Model responsible for motion/security/responsive every generation
- HTML/CSS generation with no sanitizer or sandbox
- Old approach left ambiguous as to whether it's still the focus
