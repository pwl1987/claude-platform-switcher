---
name: platform-switcher
description: Claude Code AI 平台切换器。用于在 Claude Code 中快速切换 AI 平台（MiniMax、智谱 GLM、DeepSeek、通义千问、Claude 官方），自动保存会话上下文并提示重启，支持无缝恢复工作进度。在用户提到切换平台、使用特定平台（如"切换到智谱 GLM"、"用 MiniMax 完成这个任务"）或询问当前平台时触发。
---

# Platform Switcher - Claude Code AI 平台切换器

## 技能概述

Platform Switcher 是一个 Claude Code 技能，用于在不同的 AI 平台之间快速切换。它通过切换环境变量配置来改变 Claude Code 使用的 API 端点，支持主流国产 AI 平台和 Claude 官方 API。

## 核心功能

1. **快速切换平台** - 在多个 AI 平台之间切换
2. **上下文保存** - 自动保存当前会话状态
3. **无缝恢复** - 重启后自动恢复工作进度
4. **多平台支持** - MiniMax、智谱 GLM、DeepSeek、通义千问、Claude 官方

## 触发条件

当用户出现以下情况时触发此技能：

- **明确切换意图**："切换到智谱 GLM"、"使用 MiniMax"、"换到 DeepSeek"
- **提及平台名称**："我想用通义千问"、"GLM 怎么样"
- **询问当前平台**："当前用的是什么平台"、"现在用的是哪个平台"
- **请求平台推荐**："哪个平台更适合这个任务"

## 支持的平台

| 平台 | 命令 | 特点 | 适用场景 |
|------|------|------|----------|
| **智谱 GLM** | `glm` | 三层模型映射（4.5-air/4.7/5） | 日常开发、成本优化 |
| **MiniMax** | `minimax` | 超长上下文、50分钟超时 | 复杂任务、长时间会话 |
| **DeepSeek** | `deepseek` | 快速响应 | 简单查询、快速问答 |
| **通义千问** | `qwen` | 稳定可靠 | 企业应用、生产环境 |
| **Claude 官方** | `claude` | 原生支持 | 重要任务、最新功能 |

## 使用流程

### 快速切换（推荐）

使用一键切换脚本：

```bash
~/.claude-platforms/quick-switch.sh <平台>
```

这个脚本会自动完成：
1. ✅ 切换平台
2. ✅ 加载配置
3. ✅ 保存上下文
4. ✅ 显示重启指导

然后只需：
```bash
# 1. 按 Ctrl+D 退出当前 Claude Code 会话
# 2. 执行: claude
```

### 步骤 1：确认目标平台

根据用户请求确定目标平台。如果用户没有明确指定，根据任务特点推荐最合适的平台。

**平台选择建议**：
- 日常开发、编程任务 → **智谱 GLM (Sonnet)**
- 复杂任务、长代码分析 → **MiniMax**
- 快速查询、简单问题 → **DeepSeek**
- 企业环境、稳定性要求 → **通义千问**
- 重要任务、质量优先 → **Claude 官方**

### 步骤 2：执行切换脚本（手动模式）

使用 `switch` 脚本切换平台：

```bash
~/.claude-platforms/switch <平台>
```

示例：
```bash
# 切换到智谱 GLM
~/.claude-platforms/switch glm

# 切换到 MiniMax
~/.claude-platforms/switch minimax
```

### 步骤 3：加载配置（手动模式）

切换后，需要在当前终端加载新的平台配置：

```bash
source ~/.claude-platforms/config.sh <平台>
```

示例：
```bash
source ~/.claude-platforms/config.sh glm
```

### 步骤 4：重启 Claude Code（手动模式）

加载配置后，重启 Claude Code 以使配置生效：

```bash
# 退出当前会话
# 按 Ctrl+D

# 重新启动
claude
```

## 脚本说明

### config.sh

统一配置脚本，支持所有平台：

```bash
# 用法
source config.sh <platform>

# 示例
source config.sh glm
source config.sh minimax
source config.sh deepseek
source config.sh qwen
source config.sh claude
```

功能：
- 检查 `.env` 文件是否存在
- 加载环境变量
- 验证 API Keys 是否配置
- 设置平台特定的环境变量
- 显示配置结果

### switch

平台切换脚本：

```bash
# 用法
switch <platform>

# 示例
switch glm
```

功能：
- 验证平台名称
- 保存当前平台选择
- 显示下一步操作指引

### save_context.sh

保存当前会话上下文：

```bash
~/.claude-platforms/scripts/save_context.sh
```

保存内容：
- 时间戳
- 当前平台
- 工作目录
- 会话摘要

### restore_context.sh

恢复上次保存的上下文：

```bash
~/.claude-platforms/scripts/restore_context.sh
```

### get_current_platform.sh

获取当前平台：

```bash
~/.claude-platforms/scripts/get_current_platform.sh
```

## 完整示例

### 示例 1：切换到智谱 GLM

**用户输入**：
```
切换到智谱 GLM
```

**执行步骤**：

1. 执行切换脚本：
```bash
~/.claude-platforms/switch glm
```

2. 加载配置：
```bash
source ~/.claude-platforms/config.sh glm
```

3. 重启 Claude Code：
```bash
# Ctrl+D 退出
claude
```

**Claude 响应**：
```
好的，切换到智谱 GLM 平台。

✅ 已选择平台: glm

📝 请在当前终端执行以下命令以加载配置：

   source ~/.claude-platforms/config.sh glm

然后启动 Claude Code:

   claude

重启后将继续使用智谱 GLM 平台。
```

### 示例 2：询问当前平台

**用户输入**：
```
当前用的是什么平台？
```

**Claude 响应**：
```
让我检查当前平台...

[执行 get_current_platform.sh]

当前平台：DeepSeek

如果需要切换到其他平台，请告诉我：
- glm（智谱 GLM）- 适合日常开发
- minimax（MiniMax）- 适合复杂任务
- qwen（通义千问）- 企业级稳定
- claude（官方）- 最新功能
```

### 示例 3：平台推荐

**用户输入**：
```
这个任务用哪个平台比较好？
```

**Claude 响应**：
```
根据任务特点，我推荐使用智谱 GLM (Sonnet)：

推荐理由：
- 这是编程相关任务，GLM-4.7 性价比高
- 日常开发任务的平衡选择
- 中文支持良好

是否切换到智谱 GLM？

[等待用户确认]
```

## 配置要求

### 环境变量文件

确保 `~/.claude-platforms/.env` 文件存在并包含所有 API Keys：

```bash
# 智谱 GLM
GLM_API_KEY=your-glm-api-key-here

# MiniMax (注意：使用 AUTH_TOKEN)
MINIMAX_AUTH_TOKEN=your-minimax-api-key-here

# DeepSeek
DEEPSEEK_API_KEY=your-deepseek-api-key-here

# 通义千问
QWEN_API_KEY=your-qwen-api-key-here
```

### 文件权限

确保 `.env` 文件权限安全：

```bash
chmod 600 ~/.claude-platforms/.env
```

## 故障排除

### 问题：提示 ".env 文件不存在"

**解决方案**：
```bash
# 创建 .env 文件
cp .env.example ~/.claude-platforms/.env

# 填入 API Keys
nano ~/.claude-platforms/.env
```

### 问题：提示 "API_KEY 未设置"

**解决方案**：
```bash
# 检查 .env 文件
cat ~/.claude-platforms/.env

# 确保变量名正确（无多余空格或引号）
# 正确：GLM_API_KEY=your-key
# 错误：GLM_API_KEY = your-key
# 错误：GLM_API_KEY="your-key"
```

### 问题：切换后不生效

**解决方案**：
```bash
# 手动加载配置
source ~/.claude-platforms/config.sh <平台>

# 验证环境变量
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL
```

## 参考文档

- `README.md` - 完整使用指南
- `references/platforms.md` - 平台详细信息
- `references/usage.md` - 使用示例
