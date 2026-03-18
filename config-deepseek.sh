#!/bin/bash
# DeepSeek 配置 - 从 .env 读取 API Keys

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
if [ -z "$DEEPSEEK_API_KEY" ]; then
    echo "❌ 错误: DEEPSEEK_API_KEY 未在 .env 中设置"
    exit 1
fi

# DeepSeek 配置
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY"
export ANTHROPIC_MODEL="deepseek-chat"
