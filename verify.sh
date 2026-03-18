#!/bin/bash
# Claude Code 平台切换器 - 验证测试脚本

echo "🧪 Claude Code 平台切换器 - 验证测试"
echo "======================================"
echo ""

# 测试计数
total_tests=0
passed_tests=0

run_test() {
    local test_name="$1"
    local test_cmd="$2"
    local expected="$3"

    total_tests=$((total_tests + 1))
    echo "测试 $total_tests: $test_name"

    result=$(eval "$test_cmd")

    if [ "$result" = "$expected" ]; then
        echo "  ✅ 通过"
        passed_tests=$((passed_tests + 1))
    else
        echo "  ❌ 失败"
        echo "     期望: $expected"
        echo "     实际: $result"
    fi
    echo ""
}

# 测试 1: MiniMax BASE_URL
run_test "MiniMax BASE_URL" \
    "source /root/.claude-platforms/config-minimax.sh && echo \$ANTHROPIC_BASE_URL" \
    "https://api.minimaxi.com/anthropic"

# 测试 2: MiniMax AUTH_TOKEN (前缀)
run_test "MiniMax AUTH_TOKEN 前缀" \
    "source /root/.claude-platforms/config-minimax.sh && echo \${ANTHROPIC_AUTH_TOKEN:0:10}" \
    "your-minim"

# 测试 3: MiniMax TIMEOUT
run_test "MiniMax TIMEOUT" \
    "source /root/.claude-platforms/config-minimax.sh && echo \$API_TIMEOUT_MS" \
    "3000000"

# 测试 4: MiniMax Model
run_test "MiniMax Model" \
    "source /root/.claude-platforms/config-minimax.sh && echo \$ANTHROPIC_MODEL" \
    "MiniMax-M2.7"

# 测试 5: GLM Haiku Model
run_test "GLM Haiku Model" \
    "source /root/.claude-platforms/config-glm.sh && echo \$ANTHROPIC_DEFAULT_HAIKU_MODEL" \
    "glm-4.5-air"

# 测试 6: GLM Sonnet Model
run_test "GLM Sonnet Model" \
    "source /root/.claude-platforms/config-glm.sh && echo \$ANTHROPIC_DEFAULT_SONNET_MODEL" \
    "glm-4.7"

# 测试 7: GLM Opus Model
run_test "GLM Opus Model" \
    "source /root/.claude-platforms/config-glm.sh && echo \$ANTHROPIC_DEFAULT_OPUS_MODEL" \
    "glm-5"

# 测试 8: DeepSeek BASE_URL
run_test "DeepSeek BASE_URL" \
    "source /root/.claude-platforms/config-deepseek.sh && echo \$ANTHROPIC_BASE_URL" \
    "https://api.deepseek.com"

# 测试 9: DeepSeek Model
run_test "DeepSeek Model" \
    "source /root/.claude-platforms/config-deepseek.sh && echo \$ANTHROPIC_MODEL" \
    "deepseek-chat"

# 测试 10: Qwen BASE_URL
run_test "Qwen BASE_URL" \
    "source /root/.claude-platforms/config-qwen.sh && echo \$ANTHROPIC_BASE_URL" \
    "https://dashscope.aliyuncs.com/compatible-mode/v1"

# 测试 11: Qwen Model
run_test "Qwen Model" \
    "source /root/.claude-platforms/config-qwen.sh && echo \$ANTHROPIC_MODEL" \
    "qwen-plus"

# 测试 12: Claude 配置清除
run_test "Claude 配置清除 BASE_URL" \
    "source /root/.claude-platforms/config-claude.sh && echo \${ANTHROPIC_BASE_URL:-'(unset)'}" \
    "(unset)"

# 测试 13: Claude 配置清除 API_KEY
run_test "Claude 配置清除 API_KEY" \
    "source /root/.claude-platforms/config-claude.sh && echo \${ANTHROPIC_API_KEY:-'(unset)'}" \
    "(unset)"

# 测试 14: Claude 配置清除 AUTH_TOKEN
run_test "Claude 配置清除 AUTH_TOKEN" \
    "source /root/.claude-platforms/config-claude.sh && echo \${ANTHROPIC_AUTH_TOKEN:-'(unset)'}" \
    "(unset)"

# 总结
echo "======================================"
echo "测试结果: $passed_tests / $total_tests 通过"
echo ""

if [ $passed_tests -eq $total_tests ]; then
    echo "🎉 所有测试通过!"
    exit 0
else
    echo "⚠️  部分测试失败"
    exit 1
fi
