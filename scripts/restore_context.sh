#!/bin/bash
# 恢复 Claude Code 会话上下文

CONTEXT_DIR="$HOME/.claude-platforms"
CONTEXT_FILE="$CONTEXT_DIR/session-context.json"

if [ ! -f "$CONTEXT_FILE" ]; then
    echo "ℹ️  未找到保存的上下文"
    exit 0
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 会话上下文恢复"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 读取并显示上下文
if command -v jq &> /dev/null; then
    # 如果有 jq，格式化输出
    jq -r '"🕐 时间: \(.timestamp)\n🔄 上个平台: \(.previous_platform)\n📁 工作目录: \(.current_directory)\n💬 摘要: \(.conversation_summary)"' "$CONTEXT_FILE"
else
    # 没有 jq，简单输出
    echo "🕐 时间: $(grep timestamp "$CONTEXT_FILE" | cut -d'"' -f4)"
    echo "🔄 上个平台: $(grep previous_platform "$CONTEXT_FILE" | cut -d'"' -f4)"
    echo "📁 工作目录: $(grep current_directory "$CONTEXT_FILE" | cut -d'"' -f4)"
    echo "💬 摘要: $(grep conversation_summary "$CONTEXT_FILE" | cut -d'"' -f4)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 上下文已恢复"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 清理上下文文件
rm -f "$CONTEXT_FILE"
