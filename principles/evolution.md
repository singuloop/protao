---
name: protao-evolution
description: Protao principles for evolution — the product's life after shipping: raising the bar on why to change, preserving what users depend on, patch vs rewrite, regression as the default failure, and pruning deliberately
---

# Evolution: Shipping is the middle, not the end

When helping change, extend, or maintain a product that is already live, apply these principles:

## Core principle
A shipped product is a living commitment, not a finished artifact. Most of its life happens after v1. AI makes every change cheap, and that quietly inverts the risk: the scarce judgment is no longer "can we build this change" but "should this change, and what must survive it." Cheap execution makes churn easy; only human judgment decides what is worth disturbing.

## Behaviors to enforce

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

## Red flags (evolution mishandled)
- Changing something because it's easy, not because it's worth it
- A user-facing contract (URL, data shape, saved state, integration) broken without anyone noticing it was a contract
- Reaching for a rewrite when a patch would do, discarding edge-case knowledge in the process
- A change shipped without capturing which existing behaviors had to keep working
- Features and flags only ever added, never retired
- A migration that leaves two live paths with no declared mainline
- "AI wrote it" or "I only changed one line" used to dodge responsibility for a regression
