#!/bin/bash
set -eo pipefail

MODEL_ALIAS="unsloth/Qwen3.6-27B-MTP-GGUF"

echo "No settings file changes are made by this script."

echo ""
echo "Done."
echo "  Download model   : bash macOS/download-qwen27b.sh"
echo "  Start server     : qwen27b-llama-server"
echo "  Start Claude Code: claude"
echo "  Model alias used : $MODEL_ALIAS"
