#!/bin/bash
# Claude Code 平台快速切换脚本
# 一键切换平台并加载配置
# 用法: quick-switch.sh <platform>

PLATFORM=$1
PLATFORMS_DIR="$HOME/.claude-platforms"
SWITCH_SCRIPT="$PLATFORMS_DIR/switch"
CONFIG_SCRIPT="$PLATFORMS_DIR/config.sh"
SAVE_CONTEXT_SCRIPT="$PLATFORMS_DIR/scripts/save_context.sh"

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 显示帮助
show_help() {
    echo -e "${BLUE}🔄 Claude Code 平台快速切换${NC}"
    echo ""
    echo "用法: quick-switch.sh <平台名>"
    echo ""
    echo "可用平台:"
    echo "  - glm      智谱 GLM（三层模型，性价比高）"
    echo "  - minimax  MiniMax（超长上下文，50分钟超时）"
    echo "  - deepseek DeepSeek（快速响应）"
    echo "  - qwen     通义千问（稳定可靠）"
    echo "  - claude   Claude 官方（最新功能）"
    echo ""
    echo "示例:"
    echo "  quick-switch.sh glm"
    echo ""
}

# 检查参数
if [ -z "$PLATFORM" ]; then
    show_help
    exit 1
fi

# 验证平台名称
case "$PLATFORM" in
    glm|minimax|deepseek|qwen|claude)
        ;;
    help|--help|-h)
        show_help
        exit 0
        ;;
    *)
        echo -e "${RED}❌ 错误: 未知平台 '$PLATFORM'${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac

# 1. 切换平台
echo -e "${BLUE}🔄 步骤 1/3: 切换到 $PLATFORM...${NC}"
if [ -f "$SWITCH_SCRIPT" ]; then
    bash "$SWITCH_SCRIPT" "$PLATFORM"
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ 切换失败${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ 错误: 未找到 switch 脚本${NC}"
    exit 1
fi

# 2. 加载配置
echo -e "${BLUE}📝 步骤 2/4: 加载配置...${NC}"
if [ -f "$CONFIG_SCRIPT" ]; then
    source "$CONFIG_SCRIPT" "$PLATFORM"
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ 配置加载失败${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ 错误: 未找到 config.sh 脚本${NC}"
    exit 1
fi

# 3. 更新 settings.json
echo -e "${BLUE}⚙️  步骤 3/4: 更新 settings.json...${NC}"
UPDATE_SETTINGS_SCRIPT="$PLATFORMS_DIR/update-settings.sh"
if [ -f "$UPDATE_SETTINGS_SCRIPT" ]; then
    bash "$UPDATE_SETTINGS_SCRIPT" "$PLATFORM"
else
    echo -e "${YELLOW}⚠️  未找到 update-settings.sh，跳过 settings.json 更新${NC}"
fi

# 4. 保存上下文（如果脚本存在）
if [ -f "$SAVE_CONTEXT_SCRIPT" ]; then
    echo -e "${BLUE}💾 步骤 4/4: 保存会话上下文...${NC}"
    bash "$SAVE_CONTEXT_SCRIPT" 2>/dev/null || echo "   (上下文保存可选，跳过)"
fi

# 完成
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 平台已切换到: $PLATFORM${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}📋 下一步操作:${NC}"
echo ""
echo -e "   ${BLUE}1.${NC} 按 ${YELLOW}Ctrl+D${NC} 退出当前 Claude Code 会话"
echo -e "   ${BLUE}2.${NC} 执行: ${YELLOW}claude${NC}"
echo ""
echo -e "${YELLOW}重启后将使用 $PLATFORM 平台${NC}"
echo ""
