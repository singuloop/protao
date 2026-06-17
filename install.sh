#!/usr/bin/env bash
# Usage:
#   ./install.sh <tool> [target-dir]
#
#   tool:       claude-code | codex | cursor | kiro | windsurf
#   target-dir: path to your project root (default: current directory)
#
# Tip: use "npx skills add <user>/protao" for a simpler one-command install.
#
# Example (from your project):
#   ~/protao/install.sh claude-code .
# Example (explicit path):
#   ~/protao/install.sh cursor ~/my-project

set -e

TOOL="${1:-claude-code}"
TARGET_DIR="${2:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

case "$TOOL" in
  claude-code) DEST="$TARGET_DIR/.claude/skills"    ; MODE=flat ;;
  codex)       DEST="$TARGET_DIR/.codex/skills"     ; MODE=dir  ;;
  cursor)      DEST="$TARGET_DIR/.cursor/rules"     ; MODE=flat ;;
  kiro)        DEST="$TARGET_DIR/.kiro/steering"    ; MODE=flat ;;
  windsurf)    DEST="$TARGET_DIR/.windsurf/rules"   ; MODE=flat ;;
  *)
    echo "Unknown tool: $TOOL"
    echo "Supported: claude-code | codex | cursor | kiro | windsurf"
    exit 1
    ;;
esac

mkdir -p "$DEST"

for skill_dir in "$SKILLS_DIR"/*/; do
  skill=$(basename "$skill_dir")
  src="$skill_dir/SKILL.md"
  [[ -f "$src" ]] || continue

  if [[ "$MODE" == "dir" ]]; then
    # Codex / vercel-labs/skills native format: <dest>/protao-<skill>/SKILL.md
    mkdir -p "$DEST/protao-$skill"
    cp "$src" "$DEST/protao-$skill/SKILL.md"
  else
    cp "$src" "$DEST/protao-$skill.md"
  fi
done

echo "✓ Protao skills installed → $DEST"
