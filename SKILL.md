---
name: platform-switcher
description: 此技能用于在 Claude Code 中切换 AI 平台（MiniMax、智谱 GLM、DeepSeek、通义千问、Claude 官方）。当用户说"切换到智谱 GLM"、"使用 MiniMax"、"用 DeepSeek 完成任务"、"当前是什么平台"或输入 /sw:glm、/sw:minimax、/sw:deepseek、/sw:qwen、/sw:claude 等命令时触发。
---

# Platform Switcher - Claude Code AI 平台切换器

## 技能概述

Platform Switcher 是一个 Claude Code 技能，用于在不同的 AI 平台之间快速切换。它通过切换环境变量配置来改变 Claude Code 使用的 API 端点，支持主流国产 AI 平台和 Claude 官方 API。

## 核心功能

1. **快速切换平台** - 在多个 AI 平台之间切换
2. **上下文保存** - 自动保存当前会话状态
3. **无缝恢复** - 重启后自动恢复工作进度
4. **多平台支持** - MiniMax、智谱 GLM、DeepSeek、通义千问、Claude 官方
5. **统一命令前缀** - 所有斜杠命令使用 `/sw:` 前缀

## 斜杠命令

### 平台切换命令

| 命令 | 功能 | 示例用法 |
|------|------|----------|
| `/sw:glm` | 切换到智谱 GLM | `/sw:glm` 或 "切换到智谱 GLM" |
| `/sw:minimax` | 切换到 MiniMax | `/sw:minimax` 或 "使用 MiniMax" |
| `/sw:deepseek` | 切换到 DeepSeek | `/sw:deepseek` 或 "换到 DeepSeek" |
| `/sw:qwen` | 切换到通义千问 | `/sw:qwen` 或 "用通义千问" |
| `/sw:claude` | 切换到 Claude 官方 | `/sw:claude` 或 "切回官方" |

### API Key 配置命令

| 命令 | 功能 | 示例用法 |
|------|------|----------|
| `/sw:setkey` | 交互式配置 API Key | `/sw:setkey` |
| `/sw:key-glm` | 配置智谱 GLM API Key | `/sw:key-glm` |
| `/sw:key-minimax` | 配置 MiniMax Auth Token | `/sw:key-minimax` |
| `/sw:key-deepseek` | 配置 DeepSeek API Key | `/sw:key-deepseek` |
| `/sw:key-qwen` | 配置通义千问 API Key | `/sw:key-qwen` |
| `/sw:key-claude` | 配置 Claude API Key | `/sw:key-claude` |

## 触发条件

当用户出现以下情况时触发此技能：

- **明确切换意图**："切换到智谱 GLM"、"使用 MiniMax"、"换到 DeepSeek"
- **提及平台名称**："我想用通义千问"、"GLM 怎么样"
- **询问当前平台**："当前用的是什么平台"、"现在用的是哪个平台"
- **请求平台推荐**："哪个平台更适合这个任务"
- **斜杠命令**：输入 `/sw:glm`、`/sw:minimax` 等命令

## 支持的平台

| 平台 | 命令 | 斜杠命令 | 特点 | 适用场景 |
|------|------|----------|------|----------|
| **智谱 GLM** | `glm` | `/sw:glm` | 三层模型映射（4.5-air/4.7/5） | 日常开发、成本优化 |
| **MiniMax** | `minimax` | `/sw:minimax` | 超长上下文、50分钟超时 | 复杂任务、长时间会话 |
| **DeepSeek** | `deepseek` | `/sw:deepseek` | 快速响应 | 简单查询、快速问答 |
| **通义千问** | `qwen` | `/sw:qwen` | 稳定可靠 | 企业应用、生产环境 |
| **Claude 官方** | `claude` | `/sw:claude` | 原生支持 | 重要任务、最新功能 |

## 使用流程

### 方式一：使用斜杠命令（推荐）

直接输入斜杠命令切换平台：

```
/sw:glm
```

系统会自动执行切换并提示后续操作。

### 方式二：快速切换脚本

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

### configure_api_key.sh

配置 API Key：

```bash
# 用法
~/.claude-platforms/scripts/configure_api_key.sh <platform> <api_key>

# 示例
~/.claude-platforms/scripts/configure_api_key.sh glm sk-xxxxxxxx
~/.claude-platforms/scripts/configure_api_key.sh minimax eyJhbGciOi...

# 查看当前配置
~/.claude-platforms/scripts/configure_api_key.sh show
```

## 完整示例

### 示例 1：使用斜杠命令切换

**用户输入**：
```
/sw:glm
```

**Claude 响应**：
```
好的，切换到智谱 GLM 平台。

执行切换脚本...

✅ 已选择平台: glm

📝 请在当前终端执行以下命令以加载配置：

   source ~/.claude-platforms/config.sh glm

然后启动 Claude Code:

   claude

重启后将继续使用智谱 GLM 平台。
```

### 示例 2：自然语言切换

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

### 示例 3：询问当前平台

**用户输入**：
```
当前用的是什么平台？
```

**Claude 响应**：
```
让我检查当前平台...

[执行 get_current_platform.sh]

当前平台：DeepSeek

如果需要切换到其他平台，请使用以下命令：
- /sw:glm（智谱 GLM）- 适合日常开发
- /sw:minimax（MiniMax）- 适合复杂任务
- /sw:qwen（通义千问）- 企业级稳定
- /sw:claude（官方）- 最新功能
```

### 示例 4：配置 API Key

**用户输入**：
```
/sw:key-glm
```

**Claude 响应**：
```
请提供你的智谱 GLM API Key：

[等待用户输入 API Key]

配置中...

✅ API Key 已保存到 ~/.claude-platforms/.env

现在可以使用 /sw:glm 切换到智谱 GLM 平台。
```

### 示例 5：平台推荐

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

是否切换到智谱 GLM？可以使用 /sw:glm 命令切换。

[等待用户确认]
```

## API Key 配置

### 方式一：使用斜杠命令（推荐）

```
/sw:setkey           # 交互式选择平台配置
/sw:key-glm          # 直接配置智谱 GLM
/sw:key-minimax      # 直接配置 MiniMax
/sw:key-deepseek     # 直接配置 DeepSeek
/sw:key-qwen         # 直接配置通义千问
/sw:key-claude       # 直接配置 Claude
```

### 方式二：使用配置脚本

直接在 Claude Code 中配置 API Key：

```bash
# 配置智谱 GLM
~/.claude-platforms/scripts/configure_api_key.sh glm sk-xxxxxxxx

# 配置 MiniMax
~/.claude-platforms/scripts/configure_api_key.sh minimax eyJhbGciOi...

# 配置 DeepSeek
~/.claude-platforms/scripts/configure_api_key.sh deepseek sk-xxxxxxxx

# 配置通义千问
~/.claude-platforms/scripts/configure_api_key.sh qwen sk-xxxxxxxx

# 配置 Claude 官方
~/.claude-platforms/scripts/configure_api_key.sh claude sk-ant-xxxxxx
```

查看当前配置状态：

```bash
~/.claude-platforms/scripts/configure_api_key.sh show
```

### 方式三：手动编辑 .env 文件

确保 `~/.claude-platforms/.env` 文件存在并包含所有 API Keys：

```bash
# 智谱 GLM
GLM_API_KEY=your-glm-api-key-here

# MiniMax
MINIMAX_API_KEY=your-minimax-api-key-here

# DeepSeek
DEEPSEEK_API_KEY=your-deepseek-api-key-here

# 通义千问
QWEN_API_KEY=your-qwen-api-key-here

# Claude 官方
ANTHROPIC_API_KEY=your-anthropic-api-key-here
```

### 文件权限

确保 `.env` 文件权限安全：

```bash
chmod 600 ~/.claude-platforms/.env
```

## 安装和升级

### 安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash
```

### 升级（保留配置）

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### 验证安装

```bash
# 检查版本
cat ~/.claude-platforms/VERSION

# 验证斜杠命令
ls ~/.claude/skills/ | grep sw:
```

## 故障排除

### 问题：提示 ".env 文件不存在"

**解决方案**：
```bash
# 创建 .env 文件
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env

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

### 问题：斜杠命令不识别

**解决方案**：
```bash
# 检查 skill 目录
ls ~/.claude/skills/

# 应该看到：sw:glm, sw:minimax, sw:deepseek, sw:qwen, sw:claude
# 以及：sw:setkey, sw:key-*

# 如果缺失，重新运行安装
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

## 命令速查表

| 操作 | 命令 |
|------|------|
| 切换到智谱 GLM | `/sw:glm` |
| 切换到 MiniMax | `/sw:minimax` |
| 切换到 DeepSeek | `/sw:deepseek` |
| 切换到通义千问 | `/sw:qwen` |
| 切换到 Claude | `/sw:claude` |
| 配置 API Key | `/sw:setkey` |
| 查看当前平台 | `~/.claude-platforms/switch` |
| 一键切换 | `~/.claude-platforms/quick-switch.sh <平台>` |
| 加载配置 | `source ~/.claude-platforms/config.sh <平台>` |
| 查看 API Key 状态 | `~/.claude-platforms/scripts/configure_api_key.sh show` |

## 参考文档

- `README.md` - 完整使用指南
- `docs/install.md` - 安装指南
- `docs/update.md` - 升级指南
- `references/platforms.md` - 平台详细信息
- `references/usage.md` - 使用示例
- `MODEL_MAPPING.md` - 模型映射说明
