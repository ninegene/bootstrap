#!/bin/bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/skills"

link_if_missing() {
    local link_path="$1"
    local link_target="$2"
    local link_dir
    link_dir="$(dirname "$link_path")"

    mkdir -p "$link_dir"

    if [ -e "$link_path" ] || [ -L "$link_path" ]; then
        echo "Skipping existing $link_path"
        return
    fi

    ln -s "$link_target" "$link_path"
    echo "Linked $link_path -> $link_target"
}

remove_empty_dir_if_present() {
    local dir_path="$1"

    if [ -d "$dir_path" ] && [ ! -L "$dir_path" ]; then
        if rmdir "$dir_path" 2>/dev/null; then
            echo "Removed empty $dir_path"
        fi
    fi
}

# OpenAI Codex CLI
remove_empty_dir_if_present "$HOME/.codex/skills"
link_if_missing "$HOME/.codex/skills" "$SKILLS_DIR"

# OpenCode CLI (note: singular "skill", not "skills")
link_if_missing "$HOME/.config/opencode/skill" "$SKILLS_DIR"

# Google Antigravity CLI — plugin-based; needs a plugin.json marker alongside the skills dir
ANTIGRAVITY_PLUGIN_DIR="$HOME/.gemini/antigravity-cli/plugins/user-skills"
mkdir -p "$ANTIGRAVITY_PLUGIN_DIR"
if [ ! -f "$ANTIGRAVITY_PLUGIN_DIR/plugin.json" ]; then
    printf '{\n  "name": "user-skills",\n  "description": "User-level shared agent skills"\n}\n' \
        >"$ANTIGRAVITY_PLUGIN_DIR/plugin.json"
    echo "Created $ANTIGRAVITY_PLUGIN_DIR/plugin.json"
else
    echo "Skipping existing $ANTIGRAVITY_PLUGIN_DIR/plugin.json"
fi
link_if_missing "$ANTIGRAVITY_PLUGIN_DIR/skills" "$SKILLS_DIR"

# Claude Code — directory-level symlinks are not followed; link each skill dir individually
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$CLAUDE_SKILLS_DIR"
for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    link_if_missing "$CLAUDE_SKILLS_DIR/$skill_name" "$skill_dir"
done
