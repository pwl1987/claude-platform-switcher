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

### 步骤 1：确认目标平台

根据用户请求确定目标平台。如果用户没有明确指定，根据任务特点推荐最合适的平台。

**平台选择建议**：
- 日常开发、编程任务 → **智谱 GLM (Sonnet)**
- 复杂任务、长代码分析 → **MiniMax**
- 快速查询、简单问题 → **DeepSeek**
- 企业环境、稳定性要求 → **通义千问**
- 重要任务、质量优先 → **Claude 官方**

### 步骤 2：执行切换脚本

使用 `scripts/switch_and_restart.sh` 切换平台：

```bash
~/.claude/skills/platform-switcher/scripts/switch_and_restart.sh <平台>
```

示例：
```bash
# 切换到智谱 GLM
~/.claude/skills/platform-switcher/scripts/switch_and_restart.sh glm

# 切换到 MiniMax
~/.claude/skills/platform-switcher/scripts/switch_and_restart.sh minimax
```

### 步骤 3：脚本自动执行

脚本会自动完成以下操作：

1. **显示当前状态** - 显示当前平台和目标平台
2. **保存上下文** - 调用 `save_context.sh` 保存会话信息
3. **执行切换** - 调用 `~/.claude-platforms/switch` 更新配置
4. **验证切换** - 确认新平台已生效
5. **提示重启** - 显示重启指导

### 步骤 4：指导用户重启

脚本执行完成后，需要指导用户手动重启 Claude Code：

```bash
# 1. 重新加载配置
source ~/.claude-platforms/current

# 2. 退出当前会话
# 按 Ctrl+D

# 3. 重新启动 Claude Code
claude
```

### 步骤 5：恢复上下文（可选）

在新会话开始时，可以调用 `restore_context.sh` 显示上次切换的信息：

```bash
~/.claude/skills/platform-switcher/scripts/restore_context.sh
```

这会显示：
- 上次切换的时间
- 上次使用的平台
- 当时的工作目录
- 对话摘要

## 辅助脚本

### switch_and_restart.sh

主切换脚本，执行完整的切换流程。

**用法**：
```bash
switch_and_restart.sh <平台>
```

**参数**：
- `glm` - 智谱 GLM
- `minimax` - MiniMax
- `deepseek` - DeepSeek
- `qwen` - 通义千问
- `claude` - Claude 官方

### save_context.sh

保存当前会话上下文到 `~/.claude-platforms/session-context.json`。

**保存内容**：
- 时间戳
- 当前平台
- 工作目录
- 对话摘要

### restore_context.sh

从 `~/.claude-platforms/session-context.json` 恢复会话上下文并显示信息。

### get_current_platform.sh

获取当前平台名称。

**输出**：平台名称（如 `glm`、`minimax`）或 `none`

## 参考文档

### references/platforms.md

包含所有平台的详细配置信息：
- BASE_URL
- 认证方式
- 模型配置
- 使用建议
- 配置文件示例

在用户询问特定平台的配置或特性时，查阅此文档。

### references/usage.md

包含完整的使用指南：
- 快速开始
- 命令参考
- 常见问题
- 故障排除
- 高级用法
- 最佳实践

在用户遇到问题或需要详细指导时，查阅此文档。

## 常见场景处理

### 场景 1：用户请求切换到特定平台

**用户输入**："切换到智谱 GLM"

**操作**：
1. 确认目标平台：`glm`
2. 执行：`switch_and_restart.sh glm`
3. 显示切换结果
4. 指导用户重启

**响应示例**：
```
好的，切换到智谱 GLM 平台。

[执行切换脚本...]

✅ 平台切换成功！

下一步操作：
1. 在当前终端执行：source ~/.claude-platforms/current
2. 按 Ctrl+D 退出当前会话
3. 执行：claude

重启后将继续使用智谱 GLM 平台。
```

### 场景 2：用户询问使用哪个平台

**用户输入**："这个任务用哪个平台比较好？"

**操作**：
1. 分析任务特点
2. 推荐最合适的平台
3. 说明推荐理由
4. 询问是否切换

**响应示例**：
```
根据任务特点，我推荐使用智谱 GLM (Sonnet)：

推荐理由：
- 这是编程相关任务，GLM-4.7 性价比高
- 日常开发任务的平衡选择
- 中文支持良好

是否切换到智谱 GLM？
```

### 场景 3：用户询问当前平台

**用户输入**："现在用的是哪个平台？"

**操作**：
1. 执行：`get_current_platform.sh`
2. 显示当前平台信息
3. 如需要，提供切换建议

**响应示例**：
```
当前平台：DeepSeek

如果需要切换到其他平台，请告诉我：
- glm（智谱 GLM）- 适合日常开发
- minimax（MiniMax）- 适合复杂任务
- qwen（通义千问）- 企业级稳定
- claude（官方）- 最新功能
```

### 场景 4：切换后验证

**用户输入**："切换成功了吗？"

**操作**：
1. 执行：`get_current_platform.sh`
2. 验证环境变量
3. 显示当前配置

**验证命令**：
```bash
# 获取当前平台
~/.claude/skills/platform-switcher/scripts/get_current_platform.sh

# 验证环境变量
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL
```

## 注意事项

1. **重启必需**：切换平台后必须重启 Claude Code 才能生效
2. **手动操作**：当前版本需要用户手动执行重启命令
3. **配置检查**：切换前确认目标平台的 API Key 已配置
4. **上下文限制**：保存的上下文仅包含基本信息，不包含完整对话历史

## 故障排除

### 问题 1：脚本执行失败

**可能原因**：
- 脚本没有执行权限
- 目标平台配置文件不存在

**解决方案**：
```bash
# 检查脚本权限
ls -l ~/.claude/skills/platform-switcher/scripts/

# 设置执行权限
chmod +x ~/.claude/skills/platform-switcher/scripts/*.sh

# 检查配置文件
ls -l ~/.claude-platforms/config-*.sh
```

### 问题 2：切换后不生效

**可能原因**：环境变量未重新加载

**解决方案**：
```bash
# 重新加载配置
source ~/.claude-platforms/current

# 验证
echo $ANTHROPIC_BASE_URL
```

### 问题 3：API 认证失败

**可能原因**：API Key 未配置或已失效

**解决方案**：
```bash
# 编辑配置文件
nano ~/.claude-platforms/config-glm.sh

# 填入正确的 API Key
export ANTHROPIC_API_KEY="your-actual-api-key-here"

# 重新加载
source ~/.claude-platforms/config-glm.sh
```

## 相关资源

- 主项目：https://github.com/pwl1987/claude-platform-switcher
- 智谱 AI：https://open.bigmodel.cn/
- MiniMax：https://api.minimaxi.com/
- DeepSeek：https://platform.deepseek.com/
- 通义千问：https://bailian.console.aliyun.com/
