#!/bin/bash
# Claude Code 平台切换器使用示例

echo "=== Claude Code 平台切换器使用示例 ==="
echo ""

# 1. 查看当前状态
echo "1️⃣ 查看当前状态："
switch
echo ""

# 2. 切换到智谱 GLM
echo "2️⃣ 切换到智谱 GLM："
switch glm
echo ""

# 3. 加载配置
echo "3️⃣ 加载配置："
source ~/.claude-platforms/current
echo "✅ 配置已加载"
echo ""

# 4. 验证环境变量
echo "4️⃣ 验证环境变量："
echo "   BASE_URL: $ANTHROPIC_BASE_URL"
echo "   API_KEY: ${ANTHROPIC_API_KEY:0:15}..."
echo "   MODEL: $OPENAI_MODEL"
echo ""

# 5. 启动 Claude Code（注释掉，避免实际启动）
echo "5️⃣ 启动 Claude Code："
echo "   claude"
echo ""

echo "=== 示例完成 ==="
