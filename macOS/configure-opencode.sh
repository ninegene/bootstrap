#!/bin/bash
set -eo pipefail

OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
OPENCODE_CONFIG="$OPENCODE_CONFIG_DIR/opencode.json"

# --- opencode.json: add llama-local provider ---
echo "Configuring opencode.json..."
mkdir -p "$OPENCODE_CONFIG_DIR"

python3 - <<PYEOF
import json, os, sys

config_path = "$OPENCODE_CONFIG"
config = {}
if os.path.exists(config_path):
    with open(config_path) as f:
        config = json.load(f)

provider_key = "llama-local"
if provider_key in config.get("provider", {}):
    print(f"opencode.json: '{provider_key}' provider already present, skipping.")
    sys.exit(0)

config.setdefault("\$schema", "https://opencode.ai/config.json")
config.setdefault("model", f"{provider_key}/qwen3.6-27b-mtp")

config.setdefault("provider", {})[provider_key] = {
    "npm": "@ai-sdk/openai-compatible",
    "name": "llama.cpp (local)",
    "options": {
        "baseURL": "http://127.0.0.1:8080/v1",
        "apiKey": "sk-local"
    },
    "models": {
        "qwen3.6-27b-mtp": {
            "name": "Qwen3.6 27B MTP",
            "limit": {
                "context": 4096,
                "output": 4096
            }
        }
    }
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")
print(f"opencode.json written: {config_path}")
PYEOF

echo ""
echo "Done."
echo "  Download model : bash macOS/download-qwen27b.sh"
echo "  Start server   : qwen27b-llama-server"
echo "  Open opencode  : opencode  (model: llama-local/qwen3.6-27b-mtp)"
