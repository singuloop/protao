# Protao

**English · [中文](./README.zh-CN.md)**

**Product + Tao — a practical philosophy for product development in the age of AI.**

---

For thousands of years of human civilization, philosophy has never been absent. Not because philosophy is "useful," but because **when you push any field deep enough, you inevitably arrive at philosophy** — at the questions that have no standard answer yet must still be answered.

The arrival of AI has brought product development to one of those deep questions:

> **When "execution" becomes infinitely cheap, where does "meaning" come from?**

Writing code, generating designs, running tests, writing docs — these are being taken over by AI, faster than anyone expected. This is not a threat. It's a fact, and a starting point.

Aristotle distinguished two kinds of ability: **techne** — the learnable capacity to execute, which can be tooled and taught; and **phronesis** — practical wisdom, the ability to make good judgments in situations that have no standard answer. Phronesis cannot be reduced to rules, because its essence is a sense of what is "good" and the insight to know what to do in a specific situation.

AI is taking over techne. But phronesis has not been taken over. Because the moment you fully outsource judgment, you lose ownership of the meaning of what you build.

That is why Protao exists:

> **In the age of AI, the scarcity of execution has vanished; the scarcity of judgment has, instead, become stark.**
> Protao distills the judgment a human should keep hold of, across the whole arc of product development.

---

## Tao and Technique (道 and 术)

Chinese has long held this pair of concepts. **Tao (道)** is the fundamental principle, unchanged by the specific means. **Technique (术)** is method and skill, varying with the era, the tools, the situation.

This pair becomes especially sharp in the age of AI:

- **Technique is being iterated by AI at an exponential rate.** Today's best practice may be surpassed by the next model version tomorrow. Methodology written at the level of technique rots quickly — this is not a metaphor, it is happening now.
- **Tao is the core that remains true even as models grow stronger — what's left after you distill technique upward.** It is not a hollow principle, but something you can only see after a real project has hammered it, after you've pushed deep enough.

Protao's first principle is a single sentence:

> **If an insight stops being true when you swap in a stronger model, it is technique, and should not be distilled.
> What's worth keeping is the deeper judgment behind it.**

So what's recorded here is not "how to write a prompt," but "when you should and shouldn't use AI"; not "which framework to use," but "what actually matters when choosing a framework." Not an operating manual — **a way of judging**.

---

## What this means

- We record **judgment**, not **instructions**
- We explain **why**, not **what to do step by step**
- We pursue **little and lasting**, not **much and perishable**

---

## Install

### One command (recommended)

```bash
npx skills add singuloop/protao --all
```

This uses [vercel-labs/skills](https://github.com/vercel-labs/skills) to install all Protao skills into your detected coding agent automatically.

### Manual install (for Cursor / Kiro / Windsurf)

```bash
# 1. Clone protao once
git clone https://github.com/singuloop/protao.git ~/protao

# 2. From your project root
cd my-project
~/protao/install.sh cursor      # → .cursor/rules/protao-*.md
~/protao/install.sh kiro        # → .kiro/steering/protao-*.md
~/protao/install.sh windsurf    # → .windsurf/rules/protao-*.md
~/protao/install.sh claude-code # → .claude/skills/protao-*.md (alternative to npx)
```

You can also pass an explicit target: `~/protao/install.sh cursor /path/to/project`

After installation, your agent will follow these principles across every stage of product development. See the full list below in [Skills overview](#skills-overview).

### Verify it's working

Ask your agent one of these after installing:

> "I want to build a new feature. Where should I start?"

A Protao-guided agent should ask whether the problem is real before generating solutions — not jump straight to implementation.

> "Make the UI better."

A Protao-guided agent should ask about intent and success criteria before generating variants.

If the agent responds with generic advice or jumps straight to code/design, the skills may not be loaded. Check that the files landed in the right directory for your tool.

---

## The Tao of the full lifecycle

### Discovery: Is the problem real?

AI can generate solutions at near-zero cost. This brings a danger: **you will start solving a problem that doesn't exist faster than ever before.**

The Tao of discovery is to answer this question before any generation happens:

> Is anyone actually in pain over this problem? Or do I just think they should be?

AI cannot make this judgment for you. It will fluently generate a perfect solution to the wrong problem. Judging whether the problem is real is always the human's job.

---

### Design: Intent before solution

AI can generate ten design variants in seconds. This shifts the bottleneck entirely — no longer "can I come up with a solution," but **"can I articulate what I actually want."**

The Tao of design:

> Before you let AI generate anything, you must be able to clearly describe:
> what the user is trying to accomplish, where they're blocked, and what success looks like.

Fail to state these three, and you lack the precondition for using AI in design. State them clearly, and AI becomes real leverage.

---

### Development: AI executes, the human guards the boundary

In development, AI takes over writing code. Your role undergoes a fundamental shift: **from producer to reviewer.**

Many people haven't realized this shift. They use AI to write code, then use "I didn't write that" to dodge responsibility for it. That's a trap.

The Tao of development:

> You don't need to write every line, but you need to be responsible for every line.
> That means you must be able to define what is acceptable and what is not.

Constraints — performance boundaries, security requirements, the technical-debt floor — must be given explicitly by the human. AI doesn't know your constraints; it only knows your instructions.

---

### Testing: Verify intent, not implementation

AI can write a test suite with a 100% pass rate that completely misses what you actually wanted to verify.

This isn't AI's fault. It's because most of the time, the human hasn't articulated what "correct" means.

The Tao of testing:

> Before writing the first test, answer in one sentence:
> "If this feature breaks, what would a user notice?"

That answer is what you actually need to test.

---

### Delivery: Defining "done" matters more than getting it done

AI can iterate forever. It can always make something a little better, a little more complete, a little more polished.

In delivery this becomes a trap: **without a clear definition of "done," work extends indefinitely.**

The Tao of delivery:

> Before starting any task, define its stopping condition.
> "Done" doesn't happen naturally — it is actively declared.

This judgment — "this is enough" — is something no AI can make for you. Because it requires knowing who this matters to, how much, and whether the value of shipping now exceeds the cost of continuing to polish.

---

## The cross-cutting Tao

Some judgments don't belong to a single stage — they run through the whole lifecycle, especially when the product itself is built on AI.

### Architecture: Be responsible for the running state, not just the happy path

The hard part of a system is not "creating things" — it's keeping the database, ports, external services, and real-world state consistent over time.

> Write the point of no return into the design: before it, failure can roll back; after it, failure must go to repair, not be cleaned up like an ordinary failure.

Long tasks and remote operations should be modeled as recoverable jobs, not fragile synchronous calls. The data model must express running state, historical state, and leases from the start.

### AI product: Generation is the start, not the product

Calling a model once is not a product. The core of an AI feature is building a reliable pipeline around unstable output.

> Rules filter first; AI explains last. AI should not be the first filter, but the final interpreter.

Task-ification, recoverability, automatic checking and repair, structured storage, layered fallbacks — these are what make an AI product reliable. When generating large artifacts, treat the prompt as a maintained product asset, and separate the platform's stable foundation from the model's expressive variation.

---

## Skills overview

After installation, your agent gains these principle constraints in the relevant situations:

| Skill | Covers |
|---|---|
| `discovery` | Discovery: is the problem real, don't let the product thesis drift |
| `design` | Design: intent before solution, attention is scarce, pacing cognitive load, transparency + privacy |
| `simplicity` | Simplicity: Occam's Razor, the aesthetics of module composition, code as a readable score |
| `architecture` | Architecture: state machines, job models, the system's breathing rhythm, 律 (stable foundation) / 韵 (flexible expression) |
| `development` | Development: AI executes while the human guards the boundary, local ≠ production, engineering discipline |
| `ai-product` | AI features: task-ification, layered fallbacks, rules filter first |
| `ai-generation` | AI generation: phased pipelines, prompt as asset, security sandboxing |
| `testing` | Testing: verify intent, render for real, a repeatable ship process |
| `delivery` | Delivery: define done, edge-case quality, archive feedback |

---

## Anti-patterns: these are "technique," and don't belong here

Protao explicitly does not collect the following, because they rot:

- **Specific prompt phrasings** — likely to fail after a model update
- **Tool tutorials** ("how to configure Cursor," "Claude best practices") — tools change
- **Step-by-step flows that depend on current model behavior** — behavior changes
- **Any advice starting with "currently," "right now," or "the latest version"** — that's the signature of technique

Before contributing an insight, ask yourself: **three years from now, when models are ten times as capable, will this still hold?** If not, don't submit it.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for details.

---

*🚧 Protao is taking shape. This is the first version. Contributions via Issue or PR are welcome.*
