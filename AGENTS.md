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

1. `install-xcode-command-line-tools.sh`, `install-homebrew.sh`, `setup-github-ssh-key.sh`
2. `install-aws-cli.sh`, `install-github-cli.sh`, `install-search-and-navigation-tools.sh`, `install-shellcheck-and-shfmt.sh`, `install-lefthook.sh`, `install-gnu-packages.sh`
3. `install-nvm.sh`, `install-pyenv.sh`, `install-ruby.sh`
4. `install-go.sh`, `install-llama-cpp.sh`, `install-nodejs-24.sh`, `install-uv.sh`, `install-opencode-cli.sh`, `install-openai-codex-cli.sh`, `install-claude-code.sh`, `install-ai-instructions.sh`, `install-python-3.13.sh`, `install-postgresql-18.sh`
5. `install-zsh-git-prompt.sh`, `configure-iterm.sh`, `configure-git.sh`, `configure-vim.sh`, `configure-zsh.sh`

## Code Architecture

- **[macOS/](macOS/)** — Active macOS scripts (primary focus)
- **[ubuntu-24.04/](ubuntu-24.04/)** — Active Ubuntu scripts (secondary)
- **[archive/](archive/)** — Legacy scripts for older OS versions; reference only, not actively maintained
- **[macOS/ai-instructions.md](macOS/ai-instructions.md)** / **[macOS/install-ai-instructions.sh](macOS/install-ai-instructions.sh)** — shared AI instruction template plus installer that symlinks it to Copilot, OpenCode, Codex, and Claude locations
- **[lefthook.yml](lefthook.yml)** — pre-commit hook config for `shellcheck`, `shfmt`, and `markdownlint`; installed by `bootstrap.sh` when Lefthook is available

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
