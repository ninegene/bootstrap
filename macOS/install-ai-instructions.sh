#!/bin/bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/ai-instructions.md"

link_if_missing() {
    local target_file="$1"
    local target_dir
    target_dir="$(dirname "$target_file")"

    mkdir -p "$target_dir"

    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        echo "Skipping existing $target_file"
        return
    fi

    ln -s "$TEMPLATE_FILE" "$target_file"
    echo "Linked $target_file -> $TEMPLATE_FILE"
}

link_if_missing "$HOME/.config/github-copilot/global-copilot-instructions.md"
link_if_missing "$HOME/.copilot/instructions/global.instructions.md"
link_if_missing "$HOME/.config/opencode/AGENTS.md"
link_if_missing "$HOME/.codex/AGENTS.md"
link_if_missing "$HOME/.claude/CLAUDE.md"
