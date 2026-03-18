#!/bin/bash
# 安装 platform-switcher skill 到 Claude Code

set -e

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔧 安装 platform-switcher Skill${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 项目目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="platform-switcher"
SOURCE_SKILL="$PROJECT_DIR/skills/$SKILL_NAME"
TARGET_SKILL="$HOME/.claude/skills/$SKILL_NAME"

# 检查源 skill 是否存在
if [ ! -d "$SOURCE_SKILL" ]; then
    echo -e "${YELLOW}⚠️  错误: 找不到 skill 源目录${NC}"
    echo "预期位置: $SOURCE_SKILL"
    exit 1
fi

echo -e "${GREEN}✓ 找到 skill 源目录${NC}"
echo "  源: $SOURCE_SKILL"
echo "  目标: $TARGET_SKILL"
echo ""

# 检查是否已安装
if [ -d "$TARGET_SKILL" ]; then
    echo -e "${YELLOW}⚠️  检测到已存在的 skill 安装${NC}"
    read -p "是否覆盖？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 取消安装"
        exit 1
    fi
    echo -e "${YELLOW}🗑️  删除旧安装...${NC}"
    rm -rf "$TARGET_SKILL"
fi

# 创建目标目录
echo -e "${GREEN}📁 创建目标目录...${NC}"
mkdir -p "$HOME/.claude/skills"

# 复制 skill
echo -e "${GREEN}📋 复制 skill 文件...${NC}"
cp -r "$SOURCE_SKILL" "$TARGET_SKILL"

# 设置脚本权限
echo -e "${GREEN}🔐 设置脚本权限...${NC}"
chmod +x "$TARGET_SKILL"/scripts/*.sh

# 验证安装
echo -e "${GREEN}✓ 验证安装...${NC}"
if [ -f "$TARGET_SKILL/SKILL.md" ]; then
    echo -e "${GREEN}  ✓ SKILL.md 已安装${NC}"
else
    echo -e "${YELLOW}  ✗ SKILL.md 未找到${NC}"
fi

if [ -d "$TARGET_SKILL/scripts" ]; then
    echo -e "${GREEN}  ✓ scripts/ 已安装${NC}"
    SCRIPT_COUNT=$(ls -1 "$TARGET_SKILL"/scripts/*.sh 2>/dev/null | wc -l)
    echo -e "${GREEN}    ($SCRIPT_COUNT 个脚本)${NC}"
else
    echo -e "${YELLOW}  ✗ scripts/ 未找到${NC}"
fi

if [ -d "$TARGET_SKILL/references" ]; then
    echo -e "${GREEN}  ✓ references/ 已安装${NC}"
    REF_COUNT=$(ls -1 "$TARGET_SKILL"/references/*.md 2>/dev/null | wc -l)
    echo -e "${GREEN}    ($REF_COUNT 个文档)${NC}"
else
    echo -e "${YELLOW}  ✗ references/ 未找到${NC}"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 安装完成！${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}📝 下一步操作:${NC}"
echo ""
echo "1. 重新启动 Claude Code"
echo ""
echo "2. 在 Claude Code 中测试："
echo -e "${GREEN}   切换到智谱 GLM${NC}"
echo ""
echo "3. 或直接使用脚本："
echo -e "${GREEN}   ~/.claude/skills/platform-switcher/scripts/get_current_platform.sh${NC}"
echo ""
