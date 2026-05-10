## Repository Purpose

Collection of shell scripts to bootstrap a development environment on a fresh macOS or Ubuntu 24.04 installation. Scripts are meant to be run individually in a specific order, not as a single install script.

## Running Scripts

To bootstrap a fresh macOS machine in one shot:

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

## macOS Script Execution Order

The recommended order for a fresh macOS setup (from [macOS/README.md](macOS/README.md)):

1. `install-homebrew.sh` — required first, everything else uses `brew`
2. `install-xcode-command-line-tools.sh`
3. `install-aws-cli.sh`, `install-github-cli.sh`
4. `install-fzf-and-dependencies.sh`, `install-shellcheck-and-shfmt.sh`
5. `install-nvm.sh`, `install-pyenv.sh`
6. `install-nodejs-24.sh`, `install-postgresql-18.sh`, `install-python-3.13.sh`
7. `install-cheat-and-tldr.sh`, `install-zsh-git-prompt.sh`, `install-gnu-packages.sh`
8. `configure-git.sh`, `configure-vim.sh`, `configure-zsh.sh`

## Code Architecture

- **[macOS/](macOS/)** — Active macOS scripts (primary focus)
- **[ubuntu-24.04/](ubuntu-24.04/)** — Active Ubuntu scripts (secondary)
- **[archive/](archive/)** — Legacy scripts for older OS versions; reference only, not actively maintained

## Shell Script Conventions

All scripts follow these patterns:

- **Error handling**: `set -eo pipefail` at the top
- **Idempotency**: Check if tool is already installed before installing (`command -v`, `which`, or path checks)
- **PATH management**: Append to `~/.zprofile` or `~/.bashrc` when adding new tool paths; always check before appending to avoid duplicates
- **macOS-specific**: Scripts assume Homebrew is at `/opt/homebrew` (Apple Silicon)

## EditorConfig

The [.editorconfig](.editorconfig) defines:
- Shell scripts: 4-space indent
- JS/TS: 2-space indent
- Python: 4-space indent, 88-char max line
- All files: UTF-8, LF line endings
