#!/usr/bin/env bash
# Regenerate the combined root SKILL.md from principles/*.md
# principles/*.md are the editable source; SKILL.md is generated. Never edit SKILL.md by hand.
#
# Usage: ./build-skill.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Order matters: lifecycle stages, then cross-cutting
ORDER="discovery design simplicity architecture development ai-product ai-generation testing delivery"

cat > SKILL.md <<'HEADER'
---
name: protao
description: Product development philosophy for the AI age. Applies when the task involves discovery, design, architecture, development, AI features, AI generation, testing, or delivery — any decision where human judgment should be preserved over disposable technique. Distilled judgments that survive model generations. Triggers — building a new feature/product, designing UI or a system, choosing an approach, reviewing code or UX, deciding when to use AI, defining what "done" means, or any moment that calls for a judgment a stronger model wouldn't make for you.
---

# Protao — Product development philosophy for the AI age

When "execution" becomes infinitely cheap, judgment becomes the scarce resource. AI takes over **technique** (the learnable, tool-able execution); it does not take over **judgment** (knowing what's worth doing, what "good" means, where the line is). Protao is a set of judgments — across the full product lifecycle — that a human should keep hold of, because a stronger model won't make them for you.

**First principle:** if an insight stops being true when you swap in a stronger model, it's technique, not worth following here. What's below is the judgment that survives.

Apply the relevant section to the task at hand. Each section ends with red flags — signals that the judgment is being violated.

---

HEADER

for name in $ORDER; do
  f="principles/$name.md"
  # strip frontmatter (first two --- blocks), then demote every heading one level
  # (## -> ###, then # -> ##; order matters so we don't double-demote)
  sed '1,/^---$/d; 1,/^---$/d' "$f" \
    | sed -E 's/^## /### /' \
    | sed -E 's/^# /## /' \
    >> SKILL.md
  printf '\n---\n\n' >> SKILL.md
done

echo "✓ SKILL.md regenerated from principles/ ($(echo $ORDER | wc -w | tr -d ' ') sections)"
