#!/bin/bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODEL_HF="unsloth/Qwen3.6-27B-MTP-GGUF"
MODEL_DIR="$REPO_ROOT/models/unsloth/Qwen3.6-27B-MTP-GGUF"
QUANT_PATTERN="*UD-IQ3_XXS*"
HF_TOKEN_FILE="$HOME/.cache/huggingface/token"

if ! command -v hf >/dev/null 2>&1; then
    echo "hf not found. Install it first: bash macOS/install-huggingface-hub.sh"
    exit 1
fi

# Ensure authenticated to avoid rate limits
if [ ! -s "$HF_TOKEN_FILE" ]; then
    echo "Not logged in to HuggingFace. A token is required for reliable downloads."
    echo "Get one at: https://huggingface.co/settings/tokens"
    hf auth login
fi

if ls "$MODEL_DIR"/*UD-IQ3_XXS*.gguf >/dev/null 2>&1; then
    echo "Model already downloaded: $MODEL_DIR"
    ls -lh "$MODEL_DIR"/*UD-IQ3_XXS*.gguf
    exit 0
fi

echo "Downloading $MODEL_HF ($QUANT_PATTERN) to $MODEL_DIR ..."
echo "Size: ~12.2 GB"
echo ""

mkdir -p "$MODEL_DIR"
HF_XET_HIGH_PERFORMANCE=1 hf download "$MODEL_HF" \
    --local-dir "$MODEL_DIR" \
    --include "$QUANT_PATTERN"

echo ""
echo "Downloaded:"
ls -lh "$MODEL_DIR"/*UD-IQ3_XXS*.gguf
