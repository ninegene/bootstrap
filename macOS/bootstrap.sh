#!/bin/bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

step=0
skipped=()
failed=()

run_step() {
    local label="$1"
    local script="$2"
    step=$((step + 1))
    echo ""
    echo -e "${BOLD}[$step] $label${RESET}"
    echo "────────────────────────────────────────"
    printf "Run this step? [Y/n/q] "
    read -r answer </dev/tty
    case "$answer" in
        [nN])
            echo -e "${YELLOW}— Skipped${RESET}"
            skipped+=("[$step] $label")
            return
            ;;
        [qQ])
            echo "Aborted."
            exit 0
            ;;
    esac
    if bash "$SCRIPT_DIR/$script"; then
        echo -e "${GREEN}✓ Done${RESET}"
    else
        echo -e "${RED}✗ Failed — skipping and continuing${RESET}"
        failed+=("[$step] $label")
    fi
}

echo -e "${BOLD}macOS Bootstrap${RESET}"
echo "Starting at $(date)"

# ── Prerequisites ────────────────────────────────────────────────────────────
run_step "Xcode Command Line Tools" install-xcode-command-line-tools.sh
run_step "Homebrew" install-homebrew.sh
run_step "GitHub SSH key" setup-github-ssh-key.sh

# ── CLI tools ────────────────────────────────────────────────────────────────
run_step "AWS CLI" install-aws-cli.sh
run_step "GitHub CLI" install-github-cli.sh
run_step "fzf + fd, ripgrep, bat" install-fzf-and-dependencies.sh
run_step "ShellCheck + shfmt" install-shellcheck-and-shfmt.sh
run_step "Lefthook (git hooks)" install-lefthook.sh
run_step "GNU packages" install-gnu-packages.sh

# ── Version managers ─────────────────────────────────────────────────────────
run_step "NVM (Node version manager)" install-nvm.sh
run_step "pyenv (Python version manager)" install-pyenv.sh

# ── Runtimes ─────────────────────────────────────────────────────────────────
run_step "Go" install-go.sh
run_step "Node.js 24" install-nodejs-24.sh
run_step "OpenAI Codex CLI" install-openai-codex-cli.sh
run_step "Claude Code" install-claude-code.sh
run_step "Python 3.13" install-python-3.13.sh
run_step "PostgreSQL 18" install-postgresql-18.sh

# ── Shell & editor ───────────────────────────────────────────────────────────
run_step "zsh-git-prompt" install-zsh-git-prompt.sh
run_step "iTerm2" configure-iterm.sh
run_step "Git config" configure-git.sh
run_step "Vim config" configure-vim.sh
run_step "Zsh config" configure-zsh.sh

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════"
if [ ${#skipped[@]} -gt 0 ]; then
    echo -e "${YELLOW}Skipped ${#skipped[@]} step(s):${RESET}"
    for s in "${skipped[@]}"; do
        echo -e "  ${YELLOW}— $s${RESET}"
    done
fi
if [ ${#failed[@]} -eq 0 ]; then
    echo -e "${GREEN}${BOLD}All run steps completed successfully.${RESET}"
else
    echo -e "${YELLOW}${BOLD}Completed with ${#failed[@]} failure(s):${RESET}"
    for f in "${failed[@]}"; do
        echo -e "  ${RED}✗ $f${RESET}"
    done
fi
echo "Finished at $(date)"
echo ""
echo -e "${YELLOW}Note: Open a new terminal session for all PATH changes to take effect.${RESET}"

# ── Git hooks ────────────────────────────────────────────────────────────────
echo ""
if command -v lefthook >/dev/null 2>&1; then
    echo -e "${BOLD}Installing Lefthook git hooks...${RESET}"
    (cd "$REPO_ROOT" && lefthook install)
    echo -e "${GREEN}✓ Git hooks installed${RESET}"
else
    echo -e "${YELLOW}lefthook not found — skipping hook installation${RESET}"
fi
