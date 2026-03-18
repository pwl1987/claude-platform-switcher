# Claude Code 平台切换器

极简方案，通过切换配置文件来使用不同的 AI 平台（MiniMax、智谱 GLM、DeepSeek、通义千问等）。

## ✨ 特性

- 🚀 极简设计，仅需 Bash 脚本
- ⚡ 快速切换，无需重启系统
- 🔧 易于扩展，添加新平台只需创建配置文件
- 📦 零依赖，开箱即用
- 🎯 支持多个主流 AI 平台

## 🎯 支持的平台

| 平台 | Haiku | Sonnet | Opus | 状态 |
|------|-------|--------|------|------|
| **MiniMax** | MiniMax-M2.7 | MiniMax-M2.7 | MiniMax-M2.7 | ✅ |
| **智谱 GLM** | glm-4.5-air | glm-4.7 | glm-5 | ✅ |
| **DeepSeek** | deepseek-chat | deepseek-chat | deepseek-chat | ✅ |
| **通义千问** | qwen-plus | qwen-plus | qwen-plus | ✅ |
| **Claude 官方** | claude-3-5-haiku | claude-3-5-sonnet | claude-3-5-opus | ✅ |

## 📦 快速安装

### 方法一：一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/master/install.sh | bash
```

### 方法二：手动安装

```bash
# 克隆仓库
git clone https://github.com/pwl1987/claude-platform-switcher.git ~/.claude-platforms

# 添加到 PATH
echo 'export PATH="$HOME/.claude-platforms:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## 🚀 使用方法

### 1. 配置 API Keys

编辑配置文件，填入你的 API Keys：

```bash
# 使用你喜欢的编辑器
nano ~/.claude-platforms/config-glm.sh
```

示例配置（智谱 GLM）：

```bash
#!/bin/bash
# 智谱 GLM 配置 - 完整版
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="your-actual-api-key-here"

# 模型映射
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"
```

### 2. 添加快捷命令（可选）

在 `~/.bashrc` 或 `~/.zshrc` 中添加：

```bash
# Claude Code 平台切换器
export PATH="$HOME/.claude-platforms:$PATH"
alias switch="~/.claude-platforms/switch"
alias cc="source ~/.claude-platforms/current && claude"

# 自动加载当前平台配置
if [ -f "$HOME/.claude-platforms/current" ]; then
    source "$HOME/.claude-platforms/current"
fi
```

然后执行 `source ~/.bashrc` 使配置生效。

### 3. 查看可用平台

```bash
switch
```

输出：

```
🔄 Claude Code 平台切换器

当前平台:
  ✅ glm

可用平台:
  - deepseek
  - glm
  - minimax
  - qwen

用法: switch <平台名>
示例: switch glm
```

### 4. 切换平台

```bash
# 切换到智谱 GLM
switch glm

# 切换到 MiniMax
switch minimax

# 切换到 DeepSeek
switch deepseek

# 切换到通义千问
switch qwen

# 恢复 Claude 官方 API
switch claude
```

### 5. 启动 Claude Code

```bash
# 方法1: 使用快捷命令
cc

# 方法2: 手动加载配置
source ~/.claude-platforms/current
claude
```

## 🔧 添加新平台

创建新的配置文件：

```bash
cat > ~/.claude-platforms/config-新平台名.sh << 'EOF'
#!/bin/bash
# 新平台配置
export ANTHROPIC_BASE_URL="https://api.example.com/v1"
export ANTHROPIC_API_KEY="your-api-key-here"
export ANTHROPIC_MODEL="model-name"
EOF

chmod +x ~/.claude-platforms/config-新平台名.sh
```

然后就可以使用 `switch 新平台名` 切换了。

## 📖 工作原理

1. **配置文件**：每个平台一个配置文件（`config-*.sh`），设置环境变量
2. **软链接**：使用 `current` 软链接指向当前平台的配置文件
3. **环境变量**：通过 `source` 加载配置，设置 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_API_KEY`
4. **启动应用**：Claude Code 读取环境变量，连接到对应的 API 端点

## 🧪 验证测试

```bash
# 1. 切换到智谱
switch glm

# 2. 加载配置
source ~/.claude-platforms/current

# 3. 验证环境变量
echo "BASE_URL: $ANTHROPIC_BASE_URL"
echo "API_KEY: ${ANTHROPIC_API_KEY:0:10}..."
echo "Haiku Model: $ANTHROPIC_DEFAULT_HAIKU_MODEL"
echo "Sonnet Model: $ANTHROPIC_DEFAULT_SONNET_MODEL"
echo "Opus Model: $ANTHROPIC_DEFAULT_OPUS_MODEL"

# 4. 启动 Claude Code
claude

# 5. 测试对话
# 应该使用智谱 GLM 进行响应
```

## 📁 文件结构

```
~/.claude-platforms/
├── switch              # 切换脚本
├── config-minimax.sh   # MiniMax 配置
├── config-glm.sh       # 智谱 GLM 配置
├── config-qwen.sh      # 通义千问配置
├── config-deepseek.sh  # DeepSeek 配置
├── config-claude.sh    # Claude 官方配置（恢复默认）
├── current             # 当前平台软链接
├── install.sh          # 一键安装脚本
├── README.md           # 说明文档
└── LICENSE             # MIT 许可证
```

## ❓ 常见问题

### Q: 切换后不生效？

A: 确保执行了 `source ~/.claude-platforms/current` 或重新打开终端。

### Q: 如何查看当前使用的平台？

A: 执行 `switch` 命令，会显示当前平台和可用平台。

### Q: 可以同时在多个平台使用吗？

A: 每次只能使用一个平台，但可以快速切换。

### Q: 支持哪些 shell？

A: 支持 bash、zsh 等主流 shell。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🔗 相关链接

- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [智谱 AI 开放平台](https://open.bigmodel.cn/)
- [MiniMax 开放平台](https://api.minimaxi.com/)
- [DeepSeek 开放平台](https://platform.deepseek.com/)
- [阿里云百炼平台](https://bailian.console.aliyun.com/)

## 📋 平台配置差异

| 平台 | 认证变量 | BASE_URL 路径 | 模型映射 | 超时设置 |
|------|---------|--------------|---------|---------|
| **MiniMax** | `ANTHROPIC_AUTH_TOKEN` | `/anthropic` | M2.7 (全系列) | 3000000ms |
| **智谱 GLM** | `ANTHROPIC_API_KEY` | `/api/paas/v4` | 4.5-air/4.7/5 | 默认 |
| **DeepSeek** | `ANTHROPIC_API_KEY` | - | deepseek-chat | 默认 |
| **通义千问** | `ANTHROPIC_API_KEY` | `/compatible-mode/v1` | qwen-plus | 默认 |
| **Claude 官方** | - | - | - | - |

## 📝 更新日志

### v1.1.0 (2026-03-18)
- ✅ 优化 MiniMax 配置：使用 `/anthropic` 路径和 `ANTHROPIC_AUTH_TOKEN`
- ✅ 添加完整模型映射支持（Haiku/Sonnet/Opus）
- ✅ 添加智谱 GLM 三层模型映射（4.5-air/4.7/5）
- ✅ 添加 Claude 官方配置恢复功能（`switch claude`）
- ✅ 添加超时优化和性能调优选项

### v1.0.0 (2026-03-18)
- ✅ 初始版本发布
- ✅ 支持 MiniMax、智谱 GLM、DeepSeek、通义千问
- ✅ 一键安装脚本
- ✅ 完整文档

---

**Made with ❤️ for Claude Code users**
