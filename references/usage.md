# 平台切换器使用指南

## 快速开始

### 1. 查看当前平台

```bash
~/.claude-platforms/switch
```

输出示例：
```
🔄 Claude Code 平台切换器

当前平台:
  ✅ glm

可用平台:
  - glm      智谱 GLM（三层模型，性价比高）
  - minimax  MiniMax（超长上下文，50分钟超时）
  - deepseek DeepSeek（快速响应）
  - qwen     通义千问（稳定可靠）
  - claude   Claude 官方（最新功能）
```

### 2. 切换平台

在 Claude Code 中使用斜杠命令：
```
/sw:glm
```

或使用自然语言：
```
切换到智谱 GLM
```

或使用命令行：
```bash
# 选择平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/config.sh glm

# 启动 Claude Code
claude
```

### 3. 验证切换

```bash
source ~/.claude-platforms/config.sh glm
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL
```

---

## 斜杠命令

### 平台切换

| 命令 | 功能 |
|------|------|
| `/sw:glm` | 切换到智谱 GLM |
| `/sw:minimax` | 切换到 MiniMax |
| `/sw:deepseek` | 切换到 DeepSeek |
| `/sw:qwen` | 切换到通义千问 |
| `/sw:claude` | 切换到 Claude 官方 |

### API Key 配置

| 命令 | 功能 |
|------|------|
| `/sw:setkey` | 交互式配置 API Key |
| `/sw:key-glm` | 配置智谱 GLM API Key |
| `/sw:key-minimax` | 配置 MiniMax Auth Token |
| `/sw:key-deepseek` | 配置 DeepSeek API Key |
| `/sw:key-qwen` | 配置通义千问 API Key |
| `/sw:key-claude` | 配置 Claude API Key |

---

## 命令参考

### config.sh - 统一配置脚本

所有平台的配置都通过这一个脚本完成。

**用法**：
```bash
source config.sh <平台>
```

**可用平台**：
- `glm` - 智谱 GLM
- `minimax` - MiniMax
- `deepseek` - DeepSeek
- `qwen` - 通义千问
- `claude` - Claude 官方

**示例**：
```bash
# 切换到智谱 GLM
source config.sh glm

# 切换到 MiniMax
source config.sh minimax

# 恢复 Claude 官方
source config.sh claude
```

**功能**：
- 自动检查 `.env` 文件是否存在
- 从 `.env` 加载 API Keys
- 验证必要的环境变量
- 设置平台特定的配置
- 显示配置结果

### switch - 平台切换脚本

记录平台选择并显示下一步操作指引。

**用法**：
```bash
switch <平台>
```

**示例**：
```bash
# 切换到智谱 GLM
switch glm

# 查看当前平台
switch
```

### save_context.sh

保存当前会话上下文。

自动生成 `~/.claude-platforms/session-context.json`，包含：
- 时间戳
- 当前平台
- 工作目录
- 对话摘要

**用法**：
```bash
~/.claude-platforms/scripts/save_context.sh
```

### restore_context.sh

恢复会话上下文。

在新会话开始时自动调用，显示上次切换的信息。

**用法**：
```bash
~/.claude-platforms/scripts/restore_context.sh
```

### get_current_platform.sh

获取当前平台名称。

**输出**：平台名称（如 `glm`、`minimax`）或 `none`

**用法**：
```bash
~/.claude-platforms/scripts/get_current_platform.sh
```

---

## 常见问题

### Q1: 切换后不生效？

**原因**：环境变量未重新加载

**解决**：
```bash
source ~/.claude-platforms/config.sh <平台>
```

### Q2: 找不到 switch 命令？

**原因**：未添加到 PATH

**解决方案 1**：使用完整路径
```bash
~/.claude-platforms/switch glm
```

**解决方案 2**：添加到 PATH
```bash
# 添加到 ~/.bashrc
export PATH="$HOME/.claude-platforms:$PATH"
source ~/.bashrc
```

### Q3: 提示 ".env 文件不存在"？

**解决**：
```bash
# 创建 .env 文件
cp .env.example ~/.claude-platforms/.env

# 编辑并填入 API Keys
nano ~/.claude-platforms/.env
```

### Q4: MiniMax 认证失败？

**症状**：API 返回 401 或认证错误

**原因**：使用了错误的认证变量

**解决**：
```bash
# 确认 .env 中使用 MINIMAX_API_KEY
# .env 文件内容：
MINIMAX_API_KEY=your-minimax-key

# 确认 BASE_URL 包含 /anthropic 路径
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
```

### Q5: GLM 模型未找到？

**症状**：API 返回模型不存在错误

**原因**：未正确设置模型映射

**解决**：
```bash
# 检查模型变量是否正确
source ~/.claude-platforms/config.sh glm
echo $ANTHROPIC_DEFAULT_HAIKU_MODEL   # 应该是 glm-4.5-air
echo $ANTHROPIC_DEFAULT_SONNET_MODEL  # 应该是 glm-4.7
echo $ANTHROPIC_DEFAULT_OPUS_MODEL    # 应该是 glm-5
```

### Q6: API Key 在哪里配置？

**位置**：`~/.claude-platforms/.env`

**步骤**：
```bash
# 1. 编辑 .env 文件
nano ~/.claude-platforms/.env

# 2. 填入 API Keys
GLM_API_KEY=your-actual-glm-key-here
MINIMAX_API_KEY=your-actual-minimax-key-here
DEEPSEEK_API_KEY=your-actual-deepseek-key-here
QWEN_API_KEY=your-actual-qwen-key-here

# 3. 设置文件权限
chmod 600 ~/.claude-platforms/.env

# 4. 重新加载配置
source ~/.claude-platforms/config.sh glm
```

---

## 故障排除流程

### 步骤 1：检查当前平台

```bash
~/.claude-platforms/switch
```

确认显示的平台是否正确。

### 步骤 2：验证 .env 文件

```bash
# 检查文件是否存在
ls -la ~/.claude-platforms/.env

# 检查文件权限（应该是 600）
stat ~/.claude-platforms/.env

# 查看文件内容
cat ~/.claude-platforms/.env
```

确认：
- 文件存在
- 权限正确（600）
- API Keys 已填写

### 步骤 3：测试配置脚本

```bash
# 测试加载配置
source ~/.claude-platforms/config.sh glm

# 验证环境变量
echo "BASE_URL: $ANTHROPIC_BASE_URL"
echo "Model: $ANTHROPIC_MODEL"
```

### 步骤 4：检查网络连接

```bash
# 测试智谱 GLM 连接
curl -I https://open.bigmodel.cn/api/anthropic

# 测试 MiniMax 连接
curl -I https://api.minimaxi.com/anthropic
```

确认网络可访问。

---

## 高级用法

### 创建快捷启动脚本

```bash
# 创建智谱 GLM 启动脚本
cat > ~/claude-glm.sh << 'EOF'
#!/bin/bash
~/.claude-platforms/switch glm
source ~/.claude-platforms/config.sh glm
claude
EOF

chmod +x ~/claude-glm.sh
```

使用：
```bash
~/claude-glm.sh
```

### 添加 Shell 别名

在 `~/.bashrc` 中添加：
```bash
# Claude Code 平台切换
alias cc-glm='~/.claude-platforms/switch glm && source ~/.claude-platforms/config.sh glm && claude'
alias cc-minimax='~/.claude-platforms/switch minimax && source ~/.claude-platforms/config.sh minimax && claude'
alias cc-deepseek='~/.claude-platforms/switch deepseek && source ~/.claude-platforms/config.sh deepseek && claude'
alias cc-qwen='~/.claude-platforms/switch qwen && source ~/.claude-platforms/config.sh qwen && claude'
alias cc-claude='~/.claude-platforms/switch claude && source ~/.claude-platforms/config.sh claude && claude'
```

使用：
```bash
cc-glm       # 启动智谱 GLM
cc-minimax   # 启动 MiniMax
```

### 使用默认平台

创建一个通用的 `cc` 别名，自动使用上次选择的平台：

```bash
# 添加到 ~/.bashrc
alias cc='source ~/.claude-platforms/config.sh $(cat ~/.claude-platforms/.current 2>/dev/null || echo "glm") && claude'
```

使用：
```bash
cc  # 使用上次选择的平台启动
```

---

## 最佳实践

### 1. 成本优化策略

- **日常使用**：智谱 GLM (Sonnet) - 性价比高
- **复杂任务**：MiniMax - 超长上下文，一次完成
- **快速查询**：DeepSeek - 响应快
- **重要任务**：Claude 官方 - 确保质量

### 2. 安全建议

- 🔒 **不要将 `.env` 提交到 Git**（已在 .gitignore 中）
- 🔒 定期轮换 API Keys
- 🔒 设置文件权限：`chmod 600 ~/.claude-platforms/.env`
- 🔒 使用环境变量存储 API Keys

### 3. 配置管理

使用 `.env` 文件集中管理所有 API Keys：

```bash
# ~/.claude-platforms/.env
GLM_API_KEY=your-glm-key
MINIMAX_API_KEY=your-minimax-key
DEEPSEEK_API_KEY=your-deepseek-key
QWEN_API_KEY=your-qwen-key
```

配置脚本会自动从 `.env` 读取对应的 API Key。

---

## 相关链接

- **GitHub**: https://github.com/pwl1987/claude-platform-switcher
- **Claude Code 文档**: https://docs.anthropic.com/claude-code
- **智谱 AI**: https://open.bigmodel.cn/
- **MiniMax**: https://api.minimaxi.com/
- **DeepSeek**: https://platform.deepseek.com/
- **通义千问**: https://bailian.console.aliyun.com/
