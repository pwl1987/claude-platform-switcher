# 快速开始指南

## 🚀 5 分钟快速上手

### 第一步：安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/master/install.sh | bash
```

### 第二步：配置 API Key

编辑配置文件（以智谱 GLM 为例）：

```bash
nano ~/.claude-platforms/config-glm.sh
```

将 `your-glm-api-key-here` 替换为你的实际 API Key。

### 第三步：重新加载配置

```bash
source ~/.bashrc
```

### 第四步：切换平台

```bash
switch glm
```

### 第五步：启动 Claude Code

```bash
source ~/.claude-platforms/current
claude
```

## ✅ 完成验证

启动后，在 Claude Code 中测试对话，如果使用的是智谱 GLM，说明配置成功！

## 📝 常用命令

```bash
# 查看当前状态
switch

# 切换平台
switch <平台名>

# 可用平台: glm, minimax, deepseek, qwen, claude

# 启动 Claude Code（需先 source 配置）
cc
```

## 🔧 故障排除

### 问题：找不到 switch 命令

**解决**：确保已执行 `source ~/.bashrc` 或重新打开终端。

### 问题：切换后不生效

**解决**：执行 `source ~/.claude-platforms/current` 加载新配置。

### 问题：API 调用失败

**解决**：检查 API Key 是否正确，检查网络连接。

### 问题：MiniMax 认证失败

**解决**：确认使用 `ANTHROPIC_AUTH_TOKEN` 而非 `ANTHROPIC_API_KEY`，BASE_URL 应为 `/anthropic` 路径。

### 问题：GLM 模型未找到

**解决**：确认使用正确的模型变量：
- Haiku: `ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"`
- Sonnet: `ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"`
- Opus: `ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"`

## 📚 更多信息

- 完整文档：[README.md](https://github.com/pwl1987/claude-platform-switcher/blob/master/README.md)
- 提交问题：[GitHub Issues](https://github.com/pwl1987/claude-platform-switcher/issues)

## 🔑 平台配置差异速查

| 平台 | 认证变量 | BASE_URL 路径 | 模型配置 |
|------|---------|--------------|---------|
| MiniMax | `ANTHROPIC_AUTH_TOKEN` | `/anthropic` | 全部使用 `MiniMax-M2.7` |
| 智谱 GLM | `ANTHROPIC_API_KEY` | `/api/paas/v4` | 三层模型映射 |
| DeepSeek | `ANTHROPIC_API_KEY` | - | `deepseek-chat` |
| 通义千问 | `ANTHROPIC_API_KEY` | `/compatible-mode/v1` | `qwen-plus` |
| Claude 官方 | - | - | 自动使用官方模型 |
