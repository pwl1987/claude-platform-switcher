#!/bin/bash
# 获取当前平台

CONTEXT_DIR="$HOME/.claude-platforms"
CURRENT_FILE="$CONTEXT_DIR/current"

if [ -L "$CURRENT_FILE" ]; then
    basename "$(readlink "$CURRENT_FILE")" .sh | sed 's/config-//'
else
    echo "none"
fi
