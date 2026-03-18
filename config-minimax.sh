#!/bin/bash
# MiniMax 配置 - 从 .env 读取 API Keys

# 检查 .env 文件是否存在
if [ ! -f "$HOME/.claude-platforms/.env" ]; then
    echo "⚠️  警告: 未找到 .env 文件"
    echo "   请创建 .env 文件并填入 API Keys"
    echo "   参考 .env.example 文件"
    exit 1
fi

# 加载 .env 文件
export $(grep -v '^#' "$HOME/.claude-platforms/.env" | xargs)

# 检查必要的环境变量是否设置
if [ -z "$MINIMAX_AUTH_TOKEN" ]; then
    echo "❌ 错误: MINIMAX_AUTH_TOKEN 未在 .env 中设置"
    exit 1
fi

# MiniMax 配置
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_AUTH_TOKEN"
export API_TIMEOUT_MS="3000000"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

# 模型映射
export ANTHROPIC_MODEL="MiniMax-M2.7"
export ANTHROPIC_SMALL_FAST_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
