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

## Skill file format

Each piece of Tao is a standalone `.md` file under `skills/`. The format:

```markdown
---
name: protao-<topic>
description: one line on the situation this skill covers
---

# Title: one sentence summarizing this piece of Tao

## Core principle

State it clearly: in this situation, what is the most important judgment, and why.

## Behaviors to enforce

List the behaviors the agent should perform — what to ask, what to check, when to pause.

## Red flags (signals to watch for)

- Signal one
- Signal two
```

Requirements:
- `name`: `protao-` prefix + lowercase, hyphenated
- Core principle: explain "why," not just "what"
- Behaviors: instructions the agent can act on directly, not vague advice
- Red flags: concrete signals the agent can recognize, not abstract warnings

---

## How to submit

1. Add or modify a file under `skills/`
2. Confirm it passes the "ten-times model" filter
3. Open a PR with the title: `skill: <one sentence on what this Tao is>`
4. In the PR description, explain what real situation this insight came from

It doesn't need to be perfect. A rough judgment grounded in real experience is worth more than a polished principle with no source.
