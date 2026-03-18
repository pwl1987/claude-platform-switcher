# Claude Code 平台切换器 - 使用指南

## 🚀 快速开始

### 方法一：使用本地配置文件（推荐）

```bash
# 1. 切换到智谱 GLM
~/.claude-platforms/switch glm.local

# 2. 加载配置
source ~/.claude-platforms/current

# 3. 启动 Claude Code
claude
```

### 方法二：添加到 PATH（更方便）

在 `~/.bashrc` 或 `~/.zshrc` 中添加：

```bash
# Claude Code 平台切换器
export PATH="$HOME/.claude-platforms:$PATH"
alias cc='source ~/.claude-platforms/current && claude'
```

然后执行：
```bash
source ~/.bashrc
```

### 方法三：创建快捷启动脚本

```bash
# 创建启动脚本
cat > ~/claude-glm.sh << 'EOF'
#!/bin/bash
~/.claude-platforms/switch glm.local
source ~/.claude-platforms/current
claude
EOF

chmod +x ~/claude-glm.sh

# 使用
~/claude-glm.sh
```

## 🎯 支持的平台

| 命令 | 平台 | 说明 |
|------|------|------|
| `switch glm.local` | 智谱 GLM | 三层模型映射 |
| `switch minimax.local` | MiniMax | 超长超时，复杂任务 |
| `switch deepseek` | DeepSeek | 快速响应 |
| `switch qwen` | 通义千问 | 阿里云 |
| `switch claude` | Claude 官方 | 恢复默认 |

## 📝 使用示例

### 示例 1：使用智谱 GLM

```bash
# 切换到智谱 GLM
~/.claude-platforms/switch glm.local

# 加载配置
source ~/.claude-platforms/current

# 验证配置
echo "Haiku: $ANTHROPIC_DEFAULT_HAIKU_MODEL"
echo "Sonnet: $ANTHROPIC_DEFAULT_SONNET_MODEL"
echo "Opus: $ANTHROPIC_DEFAULT_OPUS_MODEL"

# 启动 Claude Code
claude
```

### 示例 2：使用 MiniMax（复杂任务）

```bash
# 切换到 MiniMax
~/.claude-platforms/switch minimax.local

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

### 示例 3：切换回 Claude 官方

```bash
# 切换到官方 API
~/.claude-platforms/switch claude

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

## 🔧 配置 API Keys

### 方式 1：编辑本地配置文件

```bash
# 编辑智谱 GLM 配置
nano ~/.claude-platforms/config-glm.local.sh

# 编辑 MiniMax 配置
nano ~/.claude-platforms/config-minimax.local.sh
```

### 方式 2：从环境变量读取

```bash
# 在 ~/.bashrc 中添加
export GLM_API_KEY="your-glm-api-key"
export MINIMAX_API_KEY="your-minimax-api-key"
```

然后修改配置文件：
```bash
export ANTHROPIC_API_KEY="$GLM_API_KEY"
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_API_KEY"
```

## 🧪 验证配置

### 运行自动化测试

```bash
~/.claude-platforms/verify.sh
```

### 手动验证

```bash
# 切换平台
~/.claude-platforms/switch glm.local

# 加载配置
source ~/.claude-platforms/current

# 验证环境变量
echo "BASE_URL: $ANTHROPIC_BASE_URL"
echo "API Key: ${ANTHROPIC_API_KEY:0:10}..."
echo "Haiku Model: $ANTHROPIC_DEFAULT_HAIKU_MODEL"
echo "Sonnet Model: $ANTHROPIC_DEFAULT_SONNET_MODEL"
echo "Opus Model: $ANTHROPIC_DEFAULT_OPUS_MODEL"
```

## 🎨 模型选择策略

### 智谱 GLM - 三层模型

- **Haiku (glm-4.5-air)**: 快速任务，简单查询
- **Sonnet (glm-4.7)**: 日常使用，平衡性能
- **Opus (glm-5)**: 复杂任务，最高质量

### MiniMax - 统一模型

- **MiniMax-M2.7**: 全场景统一模型
- 适合长时间复杂任务（50分钟超时）

## 📊 平台选择建议

| 场景 | 推荐平台 | 原因 |
|------|---------|------|
| 日常对话 | 智谱 GLM (Sonnet) | 性价比高 |
| 复杂编程 | MiniMax | 超长上下文 |
| 快速查询 | DeepSeek | 响应快 |
| 企业应用 | 通义千问 | 稳定可靠 |
| 生产环境 | Claude 官方 | 最稳定 |

## ⚠️ 注意事项

1. **API Key 安全**
   - 不要提交 `config-*.local.sh` 到 Git
   - 定期轮换 API Keys
   - 使用文件权限保护：`chmod 600 ~/.claude-platforms/config-*.local.sh`

2. **配置加载**
   - 每次切换平台后必须执行 `source ~/.claude-platforms/current`
   - 或使用快捷命令 `cc` 自动加载

3. **模型可用性**
   - 确认您的账户有权限使用对应模型
   - 检查 API 配额和余额

## 🆘 故障排除

### 问题：命令找不到

```bash
# 使用完整路径
~/.claude-platforms/switch glm.local

# 或添加到 PATH
export PATH="$HOME/.claude-platforms:$PATH"
```

### 问题：配置不生效

```bash
# 确保加载了配置
source ~/.claude-platforms/current

# 验证环境变量
echo $ANTHROPIC_BASE_URL
```

### 问题：API 认证失败

```bash
# 检查 API Key
cat ~/.claude-platforms/config-glm.local.sh | grep API_KEY

# 检查 BASE_URL
cat ~/.claude-platforms/config-glm.local.sh | grep BASE_URL
```

## 📚 更多信息

- 完整文档：[README.md](README.md)
- 快速开始：[QUICKSTART.md](QUICKSTART.md)
- 实施总结：[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
