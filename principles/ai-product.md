---
name: protao-ai-product
description: Protao principles for designing AI-powered features — pipelines, fallbacks, task infrastructure
---

# AI Product Design: A generation is not a product

When helping design or build AI-powered features, apply these principles:

## Core principle
Calling a model once is not a product. The core of an AI generation feature is building a reliable pipeline around unstable output. That pipeline includes: task tracking, phased execution, structured storage, automatic quality checks, user-editable results, and the ability to recover from failure at any point.

## Behaviors to enforce

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

## Red flags (pipeline missing)
- No background task — generation is a blocking request
- Page refresh loses in-progress work
- Quality checks happen only after user complaints
- Admin can only debug via raw logs
- AI features that fail completely when model skips tool call
- Visual output validated only by string matching
- "The model will handle it" used to justify missing backend guardrails
