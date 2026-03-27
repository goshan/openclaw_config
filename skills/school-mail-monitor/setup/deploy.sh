#!/bin/bash
set -e

echo "=== School Mail Monitor Deploy ==="
echo ""

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" &> /dev/null && pwd)
SKILL_DIR="$HOME/.openclaw/workspace/skills/school-mail-monitor"

echo "Installing skill..."
mkdir -p "$SKILL_DIR"
cp "$SCRIPT_DIR/../SKILL.md" "$SKILL_DIR/SKILL.md"
mkdir -p "$SKILL_DIR/bins"
cp "$SCRIPT_DIR/../bins/mail_fetch" "$SKILL_DIR/bins/mail_fetch"
chmod +x "$SKILL_DIR/bins/mail_fetch"
cp "$SCRIPT_DIR/../bins/mail_extract" "$SKILL_DIR/bins/mail_extract"
chmod +x "$SKILL_DIR/bins/mail_extract"
echo "   Skill installed to $SKILL_DIR"

echo "Restart OpenClaw:"
systemctl --user restart openclaw-gateway

echo "In Slack, send 'new' to start a fresh session"
echo "   Then test with: 'Check school emails'"
echo ""
echo "=== Deploy Complete ==="
