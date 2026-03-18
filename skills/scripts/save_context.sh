#!/bin/bash
# 保存当前 Claude Code 会话上下文

CONTEXT_DIR="$HOME/.claude-platforms"
CONTEXT_FILE="$CONTEXT_DIR/session-context.json"

# 确保目录存在
mkdir -p "$CONTEXT_DIR"

# 获取当前平台
CURRENT_PLATFORM="unknown"
if [ -L "$CONTEXT_DIR/current" ]; then
    CURRENT_PLATFORM=$(basename "$(readlink "$CONTEXT_DIR/current")" .sh | sed 's/config-//')
fi

# 获取当前工作目录
CURRENT_DIR="$(pwd)"

# 获取当前时间
TIMESTAMP=$(date -Iseconds)

# 创建上下文 JSON
cat > "$CONTEXT_FILE" << EOF
{
  "timestamp": "$TIMESTAMP",
  "previous_platform": "$CURRENT_PLATFORM",
  "current_directory": "$CURRENT_DIR",
  "conversation_summary": "Platform switch initiated via skill",
  "work_state": "in_progress",
  "platform_switch": {
    "initiated": true,
    "timestamp": "$TIMESTAMP"
  }
}
EOF

echo "✅ 上下文已保存: $CONTEXT_FILE"
