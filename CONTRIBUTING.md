# Contributing to Protao

**English · [中文](./CONTRIBUTING.zh-CN.md)**

Protao collects, across the whole arc of product development, **the judgments that still hold when models are ten times as capable as they are today.**

Before contributing an insight, ask yourself this question:

> **If I used a model far stronger than today's, would this insight still mean anything?**
>
> - Yes → it's Tao (道), submit it
> - No → it's technique (术), it doesn't belong here

This isn't to say technique has no value. It's that technique rots, and only Tao distills.

---

## What you can submit

- **Judgments**: in a given situation, which choice is better, and why
- **Principles**: the shared solving logic behind a class of problems
- **Anti-patterns**: an approach that looks reasonable but causes problems, and why

What isn't accepted:

- Usage or configuration tips for specific tools
- Prompt phrasings that depend on current model behavior
- Advice starting with "currently," "right now," or "the latest version"
- Operating steps with no explanation of "why"

---

## Structure: source vs. generated

Protao ships as a **single skill** (`SKILL.md` at the repo root) so that `npx skills add` installs it as one coherent piece. But that file is **generated** — never edit it by hand.

The editable source is `principles/*.md` — one file per lifecycle area (discovery, design, architecture, …). Each is a self-contained piece of Tao. To change content:

1. Edit the relevant `principles/<area>.md`
2. Run `./build-skill.sh` to regenerate the root `SKILL.md`
3. Commit both

This keeps a single source of truth (the `principles/` files) while shipping one combined skill.

## Source file format

Each `principles/<area>.md` follows this format:

```markdown
---
name: protao-<area>
description: one line on the situation this area covers
---

# Title: one sentence summarizing this area

## Core principle

State it clearly: in this situation, what is the most important judgment, and why.

## Behaviors to enforce

List the behaviors the agent should perform — what to ask, what to check, when to pause.

## Red flags

- Signal one
- Signal two
```

Requirements:
- Core principle: explain "why," not just "what"
- Behaviors: instructions the agent can act on directly, not vague advice
- Red flags: concrete signals the agent can recognize, not abstract warnings

---

## How to submit

1. Edit or add a file under `principles/`
2. Run `./build-skill.sh` to regenerate `SKILL.md`
3. Confirm your change passes the "ten-times model" filter
4. Open a PR with the title: `principles: <one sentence on what this Tao is>`
5. In the PR description, explain what real situation this insight came from

It doesn't need to be perfect. A rough judgment grounded in real experience is worth more than a polished principle with no source.
