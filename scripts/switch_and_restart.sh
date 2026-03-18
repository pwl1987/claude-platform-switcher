#!/bin/bash
# 切换平台并重启 Claude Code

set -e

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PLATFORMS_DIR="$HOME/.claude-platforms"
SKILL_DIR="/data/Code/skill/claude-platform-switcher/.claude/skills/platform-switcher"

# 显示使用说明
show_usage() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🔄 Claude Code 平台切换器 (Skill 版)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "用法: $0 <平台>"
    echo ""
    echo "可用平台:"
    echo "  glm       - 智谱 GLM (三层模型: glm-4.5-air/4.7/5)"
    echo "  minimax   - MiniMax (MiniMax-M2.7, 50分钟超时)"
    echo "  deepseek  - DeepSeek (deepseek-chat, 快速响应)"
    echo "  qwen      - 通义千问 (qwen-plus)"
    echo "  claude    - Claude 官方 (恢复默认)"
    echo ""
    echo "示例:"
    echo "  $0 glm       # 切换到智谱 GLM"
    echo "  $0 minimax   # 切换到 MiniMax"
    echo ""
    exit 1
}

# 检查参数
if [ -z "$1" ]; then
    show_usage
fi

TARGET_PLATFORM=$1

# 验证平台名称
case "$TARGET_PLATFORM" in
    glm|minimax|deepseek|qwen|claude)
        ;;
    *)
        echo -e "${RED}❌ 错误: 未知的平台 '$TARGET_PLATFORM'${NC}"
        echo ""
        show_usage
        ;;
esac

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄 Claude Code 平台切换${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 1. 显示当前平台
echo -e "${YELLOW}📊 当前状态:${NC}"
if [ -L "$PLATFORMS_DIR/current" ]; then
    CURRENT=$(basename "$(readlink "$PLATFORMS_DIR/current")" .sh | sed 's/config-//')
    echo -e "  当前平台: ${GREEN}$CURRENT${NC}"
else
    echo -e "  当前平台: ${YELLOW}未配置${NC}"
fi
echo -e "  目标平台: ${GREEN}$TARGET_PLATFORM${NC}"
echo ""

# 2. 保存上下文
echo -e "${YELLOW}💾 保存会话上下文...${NC}"
"$SKILL_DIR/scripts/save_context.sh"
echo ""

# 3. 执行切换
echo -e "${YELLOW}🔄 切换到 $TARGET_PLATFORM...${NC}"
"$PLATFORMS_DIR/switch" "$TARGET_PLATFORM"
echo ""

# 4. 确认切换成功
if [ -L "$PLATFORMS_DIR/current" ]; then
    NEW_PLATFORM=$(basename "$(readlink "$PLATFORMS_DIR/current")" .sh | sed 's/config-//')
    if [ "$NEW_PLATFORM" = "$TARGET_PLATFORM" ]; then
        echo -e "${GREEN}✅ 平台切换成功!${NC}"
        echo ""
    else
        echo -e "${RED}❌ 切换失败${NC}"
        exit 1
    fi
fi

# 5. 提示用户手动重启
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}📝 下一步操作:${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "请在当前终端执行以下命令:"
echo ""
echo -e "${GREEN}  source ~/.claude-platforms/current${NC}"
echo ""
echo "然后重启 Claude Code:"
echo ""
echo -e "${GREEN}  # 按 Ctrl+D 退出当前会话${NC}"
echo -e "${GREEN}  # 然后执行: claude${NC}"
echo ""
echo "重启后，上下文将自动恢复。"
echo ""
