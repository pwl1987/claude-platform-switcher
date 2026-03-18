#!/bin/bash
# 一键安装 Claude Code 平台切换器

echo "🚀 安装 Claude Code 平台切换器..."

# 创建目录
mkdir -p ~/.claude-platforms
cd ~/.claude-platforms

# 检查是否已安装
if [ -f "switch" ]; then
    echo "⚠️  检测到已存在安装文件"
    read -p "是否覆盖？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 取消安装"
        exit 1
    fi
fi

# 创建 switch
cat > switch << 'SWITCH_EOF'
#!/bin/bash
# Claude Code 平台切换脚本

PLATFORMS_DIR="$HOME/.claude-platforms"
CURRENT_FILE="$PLATFORMS_DIR/current"

# 显示帮助
if [ -z "$1" ]; then
    echo "🔄 Claude Code 平台切换器"
    echo ""
    echo "当前平台:"
    if [ -L "$CURRENT_FILE" ]; then
        current=$(basename $(readlink "$CURRENT_FILE") .sh | sed 's/config-//')
        echo "  ✅ $current"
    else
        echo "  ❌ 未配置"
    fi
    echo ""
    echo "可用平台:"
    for config in "$PLATFORMS_DIR"/config-*.sh 2>/dev/null; do
        if [ -f "$config" ]; then
            name=$(basename "$config" .sh | sed 's/config-//')
            echo "  - $name"
        fi
    done
    echo ""
    echo "用法: switch <平台名>"
    echo "示例: switch glm"
    exit 0
fi

PLATFORM=$1
CONFIG_FILE="$PLATFORMS_DIR/config-$PLATFORM.sh"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 错误: 平台 '$PLATFORM' 不存在"
    echo ""
    echo "可用平台:"
    for config in "$PLATFORMS_DIR"/config-*.sh 2>/dev/null; do
        if [ -f "$config" ]; then
            name=$(basename "$config" .sh | sed 's/config-//')
            echo "  - $name"
        fi
    done
    exit 1
fi

# 切换软链接
ln -sf "$CONFIG_FILE" "$CURRENT_FILE"

echo "✅ 已切换到: $PLATFORM"
echo ""
echo "📝 请在当前终端执行以下命令以加载新配置："
echo ""
echo "   source ~/.claude-platforms/current"
echo ""
echo "然后启动 Claude Code:"
echo ""
echo "   claude"
SWITCH_EOF

# 创建配置文件
cat > config-minimax.sh << 'EOF'
#!/bin/bash
# MiniMax 配置
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/v1"
export ANTHROPIC_API_KEY="your-minimax-api-key-here"
export OPENAI_MODEL="abab6.5s-chat"
EOF

cat > config-glm.sh << 'EOF'
#!/bin/bash
# 智谱 GLM 配置
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="your-glm-api-key-here"
export OPENAI_MODEL="glm-4-plus"
EOF

cat > config-deepseek.sh << 'EOF'
#!/bin/bash
# DeepSeek 配置
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="your-deepseek-api-key-here"
export OPENAI_MODEL="deepseek-chat"
EOF

cat > config-qwen.sh << 'EOF'
#!/bin/bash
# 通义千问配置
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export ANTHROPIC_API_KEY="your-dashscope-api-key-here"
export OPENAI_MODEL="qwen-plus"
EOF

# 创建示例配置
cat > config-example.sh << 'EOF'
#!/bin/bash
# 复制此文件并重命名为 config-<平台名>.sh
# 然后填入您的 API Key

export ANTHROPIC_BASE_URL="https://api.example.com/v1"
export ANTHROPIC_API_KEY="your-api-key-here"
export OPENAI_MODEL="model-name"
EOF

# 设置权限
chmod +x switch config-*.sh

# 添加到 PATH
SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q '.claude-platforms' "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# Claude Code 平台切换器" >> "$SHELL_RC"
    echo 'export PATH="$HOME/.claude-platforms:$PATH"' >> "$SHELL_RC"
    echo 'alias switch="~/.claude-platforms/switch"' >> "$SHELL_RC"
    echo 'alias cc="source ~/.claude-platforms/current && claude"' >> "$SHELL_RC"
    echo "" >> "$SHELL_RC"
    echo "# 自动加载当前平台配置" >> "$SHELL_RC"
    echo 'if [ -f "$HOME/.claude-platforms/current" ]; then' >> "$SHELL_RC"
    echo '    source "$HOME/.claude-platforms/current"' >> "$SHELL_RC"
    echo 'fi' >> "$SHELL_RC"

    echo "✅ 已添加到 $SHELL_RC"
else
    echo "⚠️  已存在于 $SHELL_RC，跳过"
fi

echo ""
echo "✅ 安装完成！"
echo ""
echo "📝 下一步:"
echo ""
echo "1. 编辑配置文件，填入 API Keys:"
echo "   nano ~/.claude-platforms/config-*.sh"
echo ""
echo "2. 重新加载配置:"
echo "   source $SHELL_RC"
echo ""
echo "3. 切换平台:"
echo "   switch <平台名>"
echo ""
echo "4. 启动 Claude Code:"
echo "   cc"
echo ""
