#!/usr/bin/env bash
# Usage:
#   ./install.sh <tool> [target-dir]
#
#   tool:       claude-code | codex | cursor | kiro | windsurf
#   target-dir: path to your project root (default: current directory)
#
# Tip: use "npx skills add singuloop/protao" for the simplest install.
#
# Example (from your project):
#   ~/protao/install.sh claude-code .
# Example (explicit path):
#   ~/protao/install.sh cursor ~/my-project

set -e

TOOL="${1:-claude-code}"
TARGET_DIR="${2:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/SKILL.md"

case "$TOOL" in
  claude-code) DEST="$TARGET_DIR/.claude/skills/protao" ; FILE=SKILL.md ;;
  codex)       DEST="$TARGET_DIR/.codex/skills/protao"  ; FILE=SKILL.md ;;
  cursor)      DEST="$TARGET_DIR/.cursor/rules"         ; FILE=protao.md ;;
  kiro)        DEST="$TARGET_DIR/.kiro/steering"        ; FILE=protao.md ;;
  windsurf)    DEST="$TARGET_DIR/.windsurf/rules"       ; FILE=protao.md ;;
  *)
    echo "Unknown tool: $TOOL"
    echo "Supported: claude-code | codex | cursor | kiro | windsurf"
    exit 1
    ;;
esac

mkdir -p "$DEST"
cp "$SRC" "$DEST/$FILE"

echo "✓ Protao installed → $DEST/$FILE"
