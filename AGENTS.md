## Repository Purpose

Collection of shell scripts to bootstrap a development environment on a fresh macOS or Ubuntu 24.04 installation. Scripts are meant to be run individually in a specific order, not as a single install script.

## Running Scripts

To bootstrap a fresh macOS machine in one shot (interactive; the script also installs Lefthook hooks at the end if available):

```bash
bash macOS/bootstrap.sh
```

Or run individual scripts directly:

```bash
bash macOS/install-homebrew.sh
bash macOS/configure-git.sh
```

## Linting and Formatting

ShellCheck and shfmt are the linting/formatting tools for shell scripts. Install them first if not present:

```bash
bash macOS/install-shellcheck-and-shfmt.sh
```

Then lint and format:

```bash
shellcheck macOS/*.sh
shfmt -w macOS/some-script.sh
```

Use `lefthook run pre-commit` to run the staged repo checks (`shellcheck`, `shfmt`, and `markdownlint`).

## macOS Script Execution Order

The recommended order for a fresh macOS setup (from [README.md](README.md) and `macOS/bootstrap.sh`):

1. `install-xcode-command-line-tools.sh`, `install-homebrew.sh`, `setup-github-ssh-key.sh`, `disable-spotlight-indexing.sh`
2. `install-aws-cli.sh`, `install-github-cli.sh`, `install-search-and-navigation-tools.sh`, `install-shellcheck-and-shfmt.sh`, `install-lefthook.sh`, `install-gnu-packages.sh`
3. `install-nvm.sh`, `install-pyenv.sh`, `install-ruby.sh`
4. `install-go.sh`, `install-llama-cpp.sh`, `install-nodejs-24.sh`, `install-uv.sh`, `install-huggingface-hub.sh`, `install-opencode-cli.sh`, `install-crush.sh`, `install-antigravity-cli.sh`, `install-openai-codex-cli.sh`, `install-claude-code.sh`, `install-ai-agent-instructions.sh`, `install-ai-agent-skills.sh`, `install-python-3.13.sh`, `install-postgresql-18.sh`, `install-elixir.sh`
5. `configure-iterm.sh`, `configure-git.sh`, `configure-vim.sh`, `configure-zsh.sh`, `configure-opencode.sh`, `configure-claude-code.sh`

## Code Architecture

- **[macOS/](macOS/)** — Active macOS scripts (primary focus)
- **[ubuntu-24.04/](ubuntu-24.04/)** — Active Ubuntu scripts (secondary)
- **[archive/](archive/)** — Legacy scripts for older OS versions; reference only, not actively maintained
- **[macOS/ai-agent-instructions.md](macOS/ai-agent-instructions.md)** / **[macOS/install-ai-agent-instructions.sh](macOS/install-ai-agent-instructions.sh)** — user-level AI instruction template; installer symlinks it to global locations for Copilot, OpenCode, Codex, Claude, and Gemini
- **[skills/](skills/)** / **[macOS/install-ai-agent-skills.sh](macOS/install-ai-agent-skills.sh)** — user-level agent skills; installer symlinks the folder to all supported tools (see below)
- **[models/](models/)** — local LLM model storage for llama.cpp; `download-qwen27b.sh` downloads Qwen3.6-27B-MTP-GGUF here from HuggingFace
- **[macOS/configure-opencode.sh](macOS/configure-opencode.sh)** — configures OpenCode with a local llama.cpp provider pointed at the Qwen model
- **[macOS/configure-claude-code.sh](macOS/configure-claude-code.sh)** — prints Claude Code local usage notes (no file changes)
- **[lefthook.yml](lefthook.yml)** — pre-commit hook config for `shellcheck`, `shfmt`, and `markdownlint`; installed by `bootstrap.sh` when Lefthook is available

## Agent Skills

Skills live in `skills/<name>/SKILL.md`. The minimum required frontmatter is:

```yaml
---
name: skill-name
description: What the skill does and when the agent should invoke it.
---
```

Run `macOS/install-ai-agent-skills.sh` after adding a new skill. This creates symlinks in each tool's skills directory:

| Coverage                      | Path                                                                    |
| ----------------------------- | ----------------------------------------------------------------------- |
| Copilot, Codex, Crush, Gemini | `~/.agents/skills/` (one symlink covers all)                            |
| OpenCode                      | `~/.config/opencode/skill/`                                             |
| Antigravity CLI               | `~/.gemini/antigravity-cli/plugins/user-skills/skills/`                 |
| Claude Code                   | `~/.claude/skills/<name>/` (per-skill; dir-level symlinks not followed) |

Claude Code is the exception: it does not follow directory-level symlinks, so the installer loops over every skill dir in `skills/` and creates individual symlinks under `~/.claude/skills/`. Re-run the installer each time a new skill is added.

## Adding a New Install Script

When adding a new `install-*.sh` script, update **all three** of the following:

1. **`macOS/bootstrap.sh`** — add a `run_step` call in the appropriate section (Prerequisites, CLI tools, Version managers, Runtimes, or Shell & editor)
2. **`README.md`** — add the script to the ordered list under "Run bootstrap scripts to install necessary packages and tools"
3. **`AGENTS.md`** — add the script to the relevant step in "macOS Script Execution Order"

## Shell Script Conventions

All scripts follow these patterns:

- **Error handling**: `set -eo pipefail` at the top
- **Idempotency**: Check if tool is already installed before installing (`command -v`, `which`, or path checks)
- **PATH management**: Append to `~/.zprofile`, `~/.zshrc`, or `~/.bashrc` when adding new tool paths; always check before appending to avoid duplicates
- **macOS-specific**: Scripts assume Homebrew is at `/opt/homebrew` (Apple Silicon)

## EditorConfig

The [.editorconfig](.editorconfig) defines:

- Shell scripts: 4-space indent
- JS/TS: 2-space indent
- Python: 4-space indent, 88-char max line
- All files: UTF-8, LF line endings
