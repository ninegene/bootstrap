#!/bin/bash
set -eo pipefail

KEY_PATH="$HOME/.ssh/id_ed25519"
KEY_COMMENT="${1:-$(whoami)@$(hostname)}"

# ── Generate key ─────────────────────────────────────────────────────────────

if [[ -f "$KEY_PATH" ]]; then
    echo "SSH key already exists at $KEY_PATH"
    echo "Public key:"
    cat "${KEY_PATH}.pub"
else
    echo "Generating new ED25519 SSH key..."
    echo "  Key path : $KEY_PATH"
    echo "  Comment  : $KEY_COMMENT"
    echo ""
    ssh-keygen -t ed25519 -C "$KEY_COMMENT" -f "$KEY_PATH"
fi

# ── Configure SSH agent ───────────────────────────────────────────────────────

echo ""
echo "Adding key to ssh-agent..."
eval "$(ssh-agent -s)"

# Persist agent + key across reboots via ~/.ssh/config
mkdir -p ~/.ssh
chmod 700 ~/.ssh

SSH_CONFIG="$HOME/.ssh/config"
if ! grep -q "Host github.com" "$SSH_CONFIG" 2>/dev/null; then
    cat >> "$SSH_CONFIG" <<'EOF'

Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
    chmod 600 "$SSH_CONFIG"
    echo "Added GitHub entry to ~/.ssh/config"
fi

ssh-add --apple-use-keychain "$KEY_PATH"

# ── Copy public key to clipboard ─────────────────────────────────────────────

pbcopy < "${KEY_PATH}.pub"
echo ""
echo "Public key copied to clipboard."

# ── Instructions ─────────────────────────────────────────────────────────────

echo ""
echo "══════════════════════════════════════════════════════"
echo " Add your SSH key to GitHub"
echo "══════════════════════════════════════════════════════"
echo ""
echo " 1. GitHub will open in your browser."
echo "    Go to: Settings → SSH and GPG keys → New SSH key"
echo ""
echo " 2. Fill in the form:"
echo "      Title : $(hostname) (or any label you like)"
echo "      Key   : (already in your clipboard — just paste)"
echo ""
echo " 3. Click 'Add SSH key'."
echo ""
echo " 4. Come back here and press Enter to test the connection."
echo ""

open "https://github.com/settings/ssh/new"

read -r -p "Press Enter once the key is added to GitHub..." </dev/tty

# ── Test connection ───────────────────────────────────────────────────────────

echo ""
echo "Testing SSH connection to GitHub..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✓ SSH connection to GitHub is working."
else
    echo "  (GitHub returns exit code 1 even on success — checking output...)"
    ssh -T git@github.com || true
fi

echo ""
echo "Done. You can now clone GitHub repos with SSH:"
echo "  git clone git@github.com:<user>/<repo>.git"
