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
  - deepseek
  - glm
  - minimax
  - qwen
```

### 2. 切换平台

使用 Skill 切换：
```
切换到智谱 GLM
```

或直接使用脚本：
```bash
~/.claude-platforms/.claude/skills/platform-switcher/scripts/switch_and_restart.sh glm
```

### 3. 验证切换

```bash
source ~/.claude-platforms/current
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL
```

---

## 命令参考

### switch_and_restart.sh

切换平台并保存上下文。

**用法**：
```bash
switch_and_restart.sh <平台>
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
switch_and_restart.sh glm

# 切换到 MiniMax
switch_and_restart.sh minimax

# 恢复 Claude 官方
switch_and_restart.sh claude
```

### save_context.sh

保存当前会话上下文。

自动生成 `~/.claude-platforms/session-context.json`，包含：
- 时间戳
- 当前平台
- 工作目录
- 对话摘要

### restore_context.sh

恢复会话上下文。

在新会话开始时自动调用，显示上次切换的信息。

### get_current_platform.sh

获取当前平台名称。

**输出**：平台名称（如 `glm`、`minimax`）或 `none`

---

## 常见问题

### Q1: 切换后不生效？

**原因**：环境变量未重新加载

**解决**：
```bash
source ~/.claude-platforms/current
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

### Q3: MiniMax 认证失败？

**症状**：API 返回 401 或认证错误

**原因**：使用了错误的认证变量

**解决**：
```bash
# 确认使用 ANTHROPIC_AUTH_TOKEN 而非 ANTHROPIC_API_KEY
export ANTHROPIC_AUTH_TOKEN="your-minimax-key"

# 确认 BASE_URL 包含 /anthropic 路径
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
```

### Q4: GLM 模型未找到？

**症状**：API 返回模型不存在错误

**原因**：未正确设置模型映射

**解决**：
```bash
# 检查模型变量是否正确
echo $ANTHROPIC_DEFAULT_HAIKU_MODEL   # 应该是 glm-4.5-air
echo $ANTHROPIC_DEFAULT_SONNET_MODEL  # 应该是 glm-4.7
echo $ANTHROPIC_DEFAULT_OPUS_MODEL    # 应该是 glm-5
```

### Q5: API Key 在哪里配置？

**位置**：`~/.claude-platforms/config-*.sh`

**步骤**：
```bash
# 1. 编辑配置文件
nano ~/.claude-platforms/config-glm.sh

# 2. 替换 API Key
export ANTHROPIC_API_KEY="your-actual-api-key-here"

# 3. 保存并重新加载
source ~/.claude-platforms/config-glm.sh
```

---

## 故障排除流程

### 步骤 1：检查当前平台

```bash
~/.claude-platforms/switch
```

确认显示的平台是否正确。

### 步骤 2：验证配置文件

```bash
cat ~/.claude-platforms/config-glm.sh
```

确认：
- BASE_URL 正确
- API_KEY 已填写
- 模型名称正确

### 步骤 3：测试环境变量

```bash
source ~/.claude-platforms/current
echo "BASE_URL: $ANTHROPIC_BASE_URL"
echo "API_KEY: ${ANTHROPIC_API_KEY:0:10}..."
echo "Model: $ANTHROPIC_MODEL"
```

### 步骤 4：运行验证脚本

```bash
~/.claude-platforms/verify.sh
```

### 步骤 5：检查网络连接

```bash
curl -I https://open.bigmodel.cn/api/paas/v4
```

确认网络可访问。

---

## 高级用法

### 创建快捷启动脚本

```bash
# 创建智谱 GLM 启动脚本
cat > ~/claude-glm.sh << 'EOF'
#!/bin/bash
~/.claude-platforms/.claude/skills/platform-switcher/scripts/switch_and_restart.sh glm
source ~/.claude-platforms/current
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
alias cc-glm='~/.claude-platforms/switch glm && source ~/.claude-platforms/current && claude'
alias cc-minimax='~/.claude-platforms/switch minimax && source ~/.claude-platforms/current && claude'
alias cc-deepseek='~/.claude-platforms/switch deepseek && source ~/.claude-platforms/current && claude'
alias cc-qwen='~/.claude-platforms/switch qwen && source ~/.claude-platforms/current && claude'
alias cc-claude='~/.claude-platforms/switch claude && claude'
```

使用：
```bash
cc-glm       # 启动智谱 GLM
cc-minimax   # 启动 MiniMax
```

---

## 最佳实践

### 1. 成本优化策略

- **日常使用**：智谱 GLM (Sonnet) - 性价比高
- **复杂任务**：MiniMax - 超长上下文，一次完成
- **快速查询**：DeepSeek - 响应快
- **重要任务**：Claude 官方 - 确保质量

### 2. 安全建议

- 🔒 不要将 `config-*.sh` 提交到 Git
- 🔒 定期轮换 API Keys
- 🔒 设置文件权限：`chmod 600 ~/.claude-platforms/config-*.sh`
- 🔒 使用环境变量存储 API Keys

### 3. 配置管理

```bash
# 使用环境变量管理 API Keys
export GLM_API_KEY="your-glm-key"
export MINIMAX_API_KEY="your-minimax-key"

# 在配置文件中引用
export ANTHROPIC_API_KEY="$GLM_API_KEY"
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_API_KEY"
```

---

## 相关链接

- GitHub: https://github.com/pwl1987/claude-platform-switcher
- 智谱 AI: https://open.bigmodel.cn/
- MiniMax: https://api.minimaxi.com/
- DeepSeek: https://platform.deepseek.com/
- 通义千问: https://bailian.console.aliyun.com/
