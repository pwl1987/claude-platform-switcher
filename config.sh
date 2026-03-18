#!/bin/bash
# Claude Code AI 平台配置脚本
# 用法: source config.sh <platform>
# 平台: glm, minimax, deepseek, qwen, claude

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查 .env 文件是否存在
check_env_file() {
    if [ ! -f "$HOME/.claude-platforms/.env" ]; then
        echo -e "${RED}❌ 错误: 未找到 .env 文件${NC}"
        echo "   请创建 .env 文件并填入 API Keys"
        echo "   参考 .env.example 文件"
        exit 1
    fi
}

# 加载 .env 文件
load_env() {
    export $(grep -v '^#' "$HOME/.claude-platforms/.env" | xargs)
}

# 配置智谱 GLM
config_glm() {
    if [ -z "$GLM_API_KEY" ]; then
        echo -e "${RED}❌ 错误: GLM_API_KEY 未在 .env 中设置${NC}"
        exit 1
    fi

    export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
    export ANTHROPIC_API_KEY="$GLM_API_KEY"

    # 模型映射
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"

    echo -e "${GREEN}✅ 已切换到智谱 GLM${NC}"
    echo "   基础 URL: $ANTHROPIC_BASE_URL"
    echo "   模型: Haiku=$ANTHROPIC_DEFAULT_HAIKU_MODEL, Sonnet=$ANTHROPIC_DEFAULT_SONNET_MODEL, Opus=$ANTHROPIC_DEFAULT_OPUS_MODEL"
}

# 配置 MiniMax
config_minimax() {
    if [ -z "$MINIMAX_AUTH_TOKEN" ]; then
        echo -e "${RED}❌ 错误: MINIMAX_AUTH_TOKEN 未在 .env 中设置${NC}"
        exit 1
    fi

    export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
    export ANTHROPIC_AUTH_TOKEN="$MINIMAX_AUTH_TOKEN"
    export API_TIMEOUT_MS="3000000"

    # 统一模型
    export ANTHROPIC_MODEL="MiniMax-M2.7"

    echo -e "${GREEN}✅ 已切换到 MiniMax${NC}"
    echo "   基础 URL: $ANTHROPIC_BASE_URL"
    echo "   模型: $ANTHROPIC_MODEL"
    echo "   超时: $API_TIMEOUT_MS ms"
}

# 配置 DeepSeek
config_deepseek() {
    if [ -z "$DEEPSEEK_API_KEY" ]; then
        echo -e "${RED}❌ 错误: DEEPSEEK_API_KEY 未在 .env 中设置${NC}"
        exit 1
    fi

    export ANTHROPIC_BASE_URL="https://api.deepseek.com"
    export ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY"
    export ANTHROPIC_MODEL="deepseek-chat"

    echo -e "${GREEN}✅ 已切换到 DeepSeek${NC}"
    echo "   基础 URL: $ANTHROPIC_BASE_URL"
    echo "   模型: $ANTHROPIC_MODEL"
}

# 配置通义千问
config_qwen() {
    if [ -z "$QWEN_API_KEY" ]; then
        echo -e "${RED}❌ 错误: QWEN_API_KEY 未在 .env 中设置${NC}"
        exit 1
    fi

    export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
    export ANTHROPIC_API_KEY="$QWEN_API_KEY"
    export ANTHROPIC_MODEL="qwen-plus"

    echo -e "${GREEN}✅ 已切换到通义千问${NC}"
    echo "   基础 URL: $ANTHROPIC_BASE_URL"
    echo "   模型: $ANTHROPIC_MODEL"
}

# 配置 Claude 官方（恢复默认）
config_claude() {
    # 清除所有自定义配置
    unset ANTHROPIC_BASE_URL
    unset ANTHROPIC_API_KEY
    unset ANTHROPIC_AUTH_TOKEN
    unset ANTHROPIC_MODEL
    unset ANTHROPIC_DEFAULT_HAIKU_MODEL
    unset ANTHROPIC_DEFAULT_SONNET_MODEL
    unset ANTHROPIC_DEFAULT_OPUS_MODEL
    unset API_TIMEOUT_MS
    unset CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC

    echo -e "${GREEN}✅ 已切换到 Claude 官方 API${NC}"
    echo "   使用默认配置"
}

# 显示使用帮助
show_help() {
    cat << EOF
🔄 Claude Code AI 平台配置脚本

用法: source config.sh <platform>

平台:
  glm      智谱 GLM - 三层模型映射，性价比高
  minimax  MiniMax - 超长上下文，50分钟超时
  deepseek DeepSeek - 快速响应
  qwen     通义千问 - 稳定可靠
  claude   Claude 官方 - 最新功能

示例:
  source config.sh glm
  source config.sh minimax

配置文件:
  ~/.claude-platforms/.env - 存储所有 API Keys
  .env.example - 环境变量模板

相关文档:
  README.md - 完整使用指南
EOF
}

# 主逻辑
main() {
    local platform="$1"

    # 如果没有参数，显示帮助
    if [ -z "$platform" ]; then
        show_help
        return 0
    fi

    # 检查 .env 文件
    check_env_file

    # 加载环境变量
    load_env

    # 根据平台选择配置
    case "$platform" in
        glm)
            config_glm
            ;;
        minimax)
            config_minimax
            ;;
        deepseek)
            config_deepseek
            ;;
        qwen)
            config_qwen
            ;;
        claude)
            config_claude
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo -e "${RED}❌ 错误: 未知平台 '$platform'${NC}"
            echo ""
            show_help
            return 1
            ;;
    esac
}

# 执行主函数
main "$@"
