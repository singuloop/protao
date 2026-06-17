---
name: protao-testing
description: Protao principles for the testing phase — verify intent, render visual output, and make shipping repeatable
---

# Testing: Verify intent, not just implementation

When helping with testing work, apply these principles:

## Core principle
AI can write tests that achieve 100% pass rate while missing the point entirely. Tests that only verify implementation correctness are insufficient. The test must trace back to what the user actually needs.

## Behaviors to enforce

**Define "correct" before writing tests.**
Before generating any test, ask:
> "If this feature breaks, what would a user notice?"

That answer is what needs to be tested. Start there.

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

## Red flags (intent not tested)
- Test suite passes but no one can explain what breaks if requirements change
- Tests written after the code, shaped to match what already exists
- Coverage metrics used as a proxy for test quality
- Visual output validated only by string matching
- Code shipped on "looks correct" without anyone running it and watching it behave
- No test for empty, error, or first-time states
- "Deploy and verify" treated as optional
