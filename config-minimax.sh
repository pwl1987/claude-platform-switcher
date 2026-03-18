#!/bin/bash
# MiniMax 配置 - 完整版
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="your-minimax-api-key-here"
export API_TIMEOUT_MS="3000000"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

# 模型映射
export ANTHROPIC_MODEL="MiniMax-M2.7"
export ANTHROPIC_SMALL_FAST_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
