#!/bin/bash
# API Key 配置脚本
# 用法: configure_api_key.sh <platform> <api_key>
# 平台: glm, minimax, deepseek, qwen, claude

set -e

PLATFORMS_DIR="$HOME/.claude-platforms"
ENV_FILE="$PLATFORMS_DIR/.env"

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# API Key 变量名映射
declare -A API_KEY_VARS=(
    ["glm"]="GLM_API_KEY"
    ["minimax"]="MINIMAX_API_KEY"
    ["deepseek"]="DEEPSEEK_API_KEY"
    ["qwen"]="QWEN_API_KEY"
    ["claude"]="ANTHROPIC_API_KEY"
)

# API Key 名称映射
declare -A API_KEY_NAMES=(
    ["glm"]="智谱 GLM API Key"
    ["minimax"]="MiniMax API Key"
    ["deepseek"]="DeepSeek API Key"
    ["qwen"]="通义千问 API Key"
    ["claude"]="Claude API Key"
)

# 显示帮助
show_help() {
    echo -e "${BLUE}🔑 API Key 配置工具${NC}"
    echo ""
    echo "用法: configure_api_key.sh <平台> <API Key>"
    echo ""
    echo "支持的平台:"
    echo "  glm      - 智谱 GLM (变量: GLM_API_KEY)"
    echo "  minimax  - MiniMax (变量: MINIMAX_API_KEY)"
    echo "  deepseek - DeepSeek (变量: DEEPSEEK_API_KEY)"
    echo "  qwen     - 通义千问 (变量: QWEN_API_KEY)"
    echo "  claude   - Claude 官方 (变量: ANTHROPIC_API_KEY)"
    echo ""
    echo "示例:"
    echo "  configure_api_key.sh glm sk-xxxxxxxx"
    echo "  configure_api_key.sh minimax sk-xxxxxxxx"
    echo ""
    echo "查看当前配置:"
    echo "  configure_api_key.sh show"
    echo ""
}

# 显示所有配置
show_config() {
    echo -e "${BLUE}📋 当前 API Key 配置状态:${NC}"
    echo ""

    if [ ! -f "$ENV_FILE" ]; then
        echo -e "${YELLOW}⚠️  .env 文件不存在${NC}"
        echo "   请先运行安装脚本: bash install.sh"
        return 1
    fi

    for platform in glm minimax deepseek qwen claude; do
        local var_name="${API_KEY_VARS[$platform]}"
        local display_name="${API_KEY_NAMES[$platform]}"

        if grep -q "^${var_name}=" "$ENV_FILE" 2>/dev/null; then
            local value=$(grep "^${var_name}=" "$ENV_FILE" | cut -d'=' -f2-)
            if [ -n "$value" ] && [ "$value" != "your-${platform}-api-key-here" ] && [ "$value" != "your-${platform}-key-here" ]; then
                # 显示前8位和后4位
                local len=${#value}
                if [ $len -gt 12 ]; then
                    local masked="${value:0:8}...${value: -4}"
                else
                    local masked="***已设置***"
                fi
                echo -e "  ${GREEN}✅ $display_name:${NC} $masked"
            else
                echo -e "  ${YELLOW}⚠️  $display_name:${NC} 未配置"
            fi
        else
            echo -e "  ${RED}❌ $display_name:${NC} 未找到"
        fi
    done

    echo ""
}

# 配置 API Key
configure_key() {
    local platform="$1"
    local api_key="$2"
    local var_name="${API_KEY_VARS[$platform]}"
    local display_name="${API_KEY_NAMES[$platform]}"

    if [ -z "$var_name" ]; then
        echo -e "${RED}❌ 错误: 未知平台 '$platform'${NC}"
        show_help
        exit 1
    fi

    # 确保目录存在
    mkdir -p "$PLATFORMS_DIR"

    # 如果 .env 不存在，从模板创建
    if [ ! -f "$ENV_FILE" ]; then
        if [ -f "$PLATFORMS_DIR/.env.example" ]; then
            cp "$PLATFORMS_DIR/.env.example" "$ENV_FILE"
        else
            touch "$ENV_FILE"
        fi
        chmod 600 "$ENV_FILE"
    fi

    # 检查变量是否已存在
    if grep -q "^${var_name}=" "$ENV_FILE" 2>/dev/null; then
        # 更新现有值
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s|^${var_name}=.*|${var_name}=${api_key}|" "$ENV_FILE"
        else
            # Linux
            sed -i "s|^${var_name}=.*|${var_name}=${api_key}|" "$ENV_FILE"
        fi
        echo -e "${GREEN}✅ 已更新 $display_name${NC}"
    else
        # 添加新值
        echo "" >> "$ENV_FILE"
        echo "# $display_name" >> "$ENV_FILE"
        echo "${var_name}=${api_key}" >> "$ENV_FILE"
        echo -e "${GREEN}✅ 已添加 $display_name${NC}"
    fi

    # 确保文件权限安全
    chmod 600 "$ENV_FILE"

    echo ""
    echo -e "${BLUE}📝 配置已保存到: $ENV_FILE${NC}"
    echo ""
}

# 主逻辑
main() {
    local platform="$1"
    local api_key="$2"

    # 显示帮助
    if [ -z "$platform" ] || [ "$platform" = "help" ] || [ "$platform" = "--help" ] || [ "$platform" = "-h" ]; then
        show_help
        exit 0
    fi

    # 显示配置
    if [ "$platform" = "show" ] || [ "$platform" = "list" ] || [ "$platform" = "status" ]; then
        show_config
        exit 0
    fi

    # 检查 API Key 参数
    if [ -z "$api_key" ]; then
        echo -e "${RED}❌ 错误: 请提供 API Key${NC}"
        echo ""
        echo "用法: configure_api_key.sh $platform <API Key>"
        exit 1
    fi

    # 配置 API Key
    configure_key "$platform" "$api_key"
}

# 执行主函数
main "$@"
