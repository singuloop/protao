---
name: protao-simplicity
description: Protao principles for simplicity — Occam's Razor, module composition, and code as a readable score
---

# Simplicity: Nothing left to remove

When helping with architecture, code design, or system decisions, apply these principles.

## Core principle
Complexity is not sophistication. A system is simple not when there is nothing more to add, but when there is nothing left to remove while still fully serving its purpose. The burden of proof always falls on the complex solution, not the simple one.

This is Occam's Razor applied to engineering — and it is a form of discipline, not laziness. The simplest correct path is often harder to find than an elaborate one.

## Behaviors to enforce

**Apply Occam's Razor at every decision point.**
Before introducing a new abstraction, service, or dependency, ask: does the simpler alternative fully solve the problem?
- 3 lines of code before 30
- A simple queue before a distributed cluster
- A direct call before an event bus, unless indirection is genuinely warranted
- A single process before microservices

When both paths work, the simpler one is better — it's cheaper to understand, cheaper to change, and cheaper to debug. This applies regardless of how technically interesting the complex path is.

**Treat module boundaries as composition.**
A module's boundary clarity is its architecture. Single Responsibility is the minimalism of system design: a module that does one thing, does it completely, and asks for exactly what it needs — no more.

- **Cohesion**: the parts inside a module belong together. If you have to explain why several things are in the same module, they probably aren't.
- **Coupling**: the module depends on exactly what it needs. If removing a dependency requires rewriting the module, the dependency wasn't optional — it was baked in.

Both degrade over time without deliberate attention. Tune both.

**Write code as a readable score.**
Code is read far more than it is written. A function should say what it does in its name. A file should say what it contains in its structure. Layers should go where they semantically belong.

- Obvious code that does exactly what it says > clever code that requires decoding
- Determinism over surprise: a reader should never have to wonder what a piece of code will do
- Refactoring is noise reduction: "bad smells" (long methods, mystery names, tangled concerns, duplicated logic) are noise in the score — they make the next reader misread the intent

When code needs a comment to explain *what* it does, the code should be renamed or restructured. Comments explain *why*, not *what*.

## Red flags (unnecessary complexity)
- "Let's add a message queue / cache / abstraction layer just in case"
- A module that has knowledge of many other modules
- Naming that requires reading the implementation to understand
- An abstraction layer that doesn't simplify the caller's code
- The complex solution chosen because it's more interesting to build
- A comment that explains what the code does (instead of why)
- Passing a code review despite no one being able to explain the simplest version of what it does
