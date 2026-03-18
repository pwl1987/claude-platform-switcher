# 支持的 AI 平台

本文档详细介绍了 Claude Code 平台切换器支持的所有 AI 平台。

## 平台概览

| 平台 | 命令 | BASE_URL | 认证方式 | 适用场景 |
|------|------|----------|----------|----------|
| **智谱 GLM** | `glm` | `https://open.bigmodel.cn/api/paas/v4` | `API_KEY` | 日常开发、成本优化 |
| **MiniMax** | `minimax` | `https://api.minimaxi.com/anthropic` | `AUTH_TOKEN` | 复杂任务、长时间会话 |
| **DeepSeek** | `deepseek` | `https://api.deepseek.com` | `API_KEY` | 快速查询、简单任务 |
| **通义千问** | `qwen` | `https://dashscope.aliyuncs.com/compatible-mode/v1` | `API_KEY` | 企业应用、稳定可靠 |
| **Claude 官方** | `claude` | 默认 | 默认 | 生产环境、最新功能 |

---

## MiniMax

### 基本信息
- **命令**: `minimax`
- **BASE_URL**: `https://api.minimaxi.com/anthropic`
- **环境变量**: `MINIMAX_AUTH_TOKEN`（注意：不同于其他平台的 API_KEY）
- **适用场景**: 复杂任务、长时间会话

### 使用方式
```bash
# 选择平台
~/.claude-platforms/switch minimax

# 加载配置
source ~/.claude-platforms/config.sh minimax
```

### 环境变量配置
```bash
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_AUTH_TOKEN"
export API_TIMEOUT_MS="3000000"  # 50分钟超时
export ANTHROPIC_MODEL="MiniMax-M2.7"
```

### 特色配置
- **超时时间**: 3000000ms (50分钟) - 适合超长上下文任务
- **路径**: `/anthropic` - 专用的 Anthropic 兼容端点

### .env 配置
```bash
MINIMAX_AUTH_TOKEN=your-minimax-api-key-here
```

### 使用建议
- ✅ 复杂编程任务
- ✅ 长时间会话
- ✅ 大文件分析
- ❌ 快速查询（用 DeepSeek 更快）

---

## 智谱 GLM

### 基本信息
- **命令**: `glm`
- **BASE_URL**: `https://open.bigmodel.cn/api/paas/v4`
- **环境变量**: `GLM_API_KEY`
- **适用场景**: 日常使用、平衡性能

### 使用方式
```bash
# 选择平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/config.sh glm
```

### 环境变量配置（三层模型映射）
```bash
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="$GLM_API_KEY"

# 三层模型映射
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"  # 快速任务
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"     # 日常使用
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"         # 复杂任务
```

### 模型说明
- **glm-4.5-air (Haiku)**: 轻量快速，适合简单查询
- **glm-4.7 (Sonnet)**: 日常使用的平衡选择
- **glm-5 (Opus)**: 最强模型，适合复杂任务

### .env 配置
```bash
GLM_API_KEY=your-glm-api-key-here
```

### 使用建议
- ✅ 日常开发
- ✅ 成本优化
- ✅ 中文任务优化
- ✅ 三层模型灵活选择

---

## DeepSeek

### 基本信息
- **命令**: `deepseek`
- **BASE_URL**: `https://api.deepseek.com`
- **环境变量**: `DEEPSEEK_API_KEY`
- **适用场景**: 快速响应、简单任务

### 使用方式
```bash
# 选择平台
~/.claude-platforms/switch deepseek

# 加载配置
source ~/.claude-platforms/config.sh deepseek
```

### 环境变量配置
```bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY"
export ANTHROPIC_MODEL="deepseek-chat"
```

### 特色
- 响应速度快
- 性价比高
- 适合简单任务

### .env 配置
```bash
DEEPSEEK_API_KEY=your-deepseek-api-key-here
```

### 使用建议
- ✅ 快速问答
- ✅ 简单代码生成
- ✅ 成本敏感场景
- ❌ 复杂推理（建议用 GLM-5 或 MiniMax）

---

## 通义千问

### 基本信息
- **命令**: `qwen`
- **BASE_URL**: `https://dashscope.aliyuncs.com/compatible-mode/v1`
- **环境变量**: `QWEN_API_KEY`
- **适用场景**: 企业应用、稳定可靠

### 使用方式
```bash
# 选择平台
~/.claude-platforms/switch qwen

# 加载配置
source ~/.claude-platforms/config.sh qwen
```

### 环境变量配置
```bash
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export ANTHROPIC_API_KEY="$QWEN_API_KEY"
export ANTHROPIC_MODEL="qwen-plus"
```

### 特色
- 阿里云基础设施
- 稳定可靠
- 企业级支持

### .env 配置
```bash
QWEN_API_KEY=your-qwen-api-key-here
```

### 使用建议
- ✅ 企业环境
- ✅ 生产环境
- ✅ 需要稳定性的场景
- ✅ 阿里云用户

---

## Claude 官方

### 基本信息
- **命令**: `claude`
- **BASE_URL**: 默认（无需配置）
- **环境变量**: 默认（使用官方 API Key）
- **适用场景**: 生产环境、最新功能

### 使用方式
```bash
# 选择平台
~/.claude-platforms/switch claude

# 加载配置
source ~/.claude-platforms/config.sh claude
```

### 环境变量配置
```bash
# 清除所有自定义配置，恢复使用 Claude 官方 API
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_API_KEY
unset ANTHROPIC_AUTH_TOKEN
unset ANTHROPIC_MODEL
unset ANTHROPIC_DEFAULT_HAIKU_MODEL
unset ANTHROPIC_DEFAULT_SONNET_MODEL
unset ANTHROPIC_DEFAULT_OPUS_MODEL
unset API_TIMEOUT_MS
```

### 特色
- 最稳定
- 最新模型
- 官方支持

### .env 配置（可选）
```bash
# 如果使用官方 API，可以配置
ANTHROPIC_API_KEY=sk-ant-xxxxx
```

### 使用建议
- ✅ 生产环境
- ✅ 重要任务
- ✅ 需要最新功能
- ❌ 成本敏感场景

---

## 平台选择建议

### 根据任务类型选择

| 场景 | 推荐平台 | 原因 |
|------|---------|------|
| 日常开发 | 智谱 GLM (Sonnet) | 性价比高，三层模型灵活 |
| 复杂编程 | MiniMax | 超长上下文，50分钟超时 |
| 快速查询 | DeepSeek | 响应快 |
| 企业应用 | 通义千问 | 稳定可靠 |
| 生产环境 | Claude 官方 | 最稳定 |
| 成本优化 | 智谱 GLM | 国产平台价格优势 |

### 根据模型特点选择

| 模型特点 | 推荐平台 | 模型 |
|---------|---------|------|
| 需要三层模型 | 智谱 GLM | glm-4.5-air/4.7/5 |
| 超长上下文 | MiniMax | MiniMax-M2.7 |
| 快速响应 | DeepSeek | deepseek-chat |
| 企业级稳定 | 通义千问 | qwen-plus |
| 最新功能 | Claude 官方 | claude-sonnet-4-20250514 |

---

## 配置示例

### .env 文件完整示例

```bash
# API Keys 配置
# 注意：不要将此文件提交到 Git

# 智谱 GLM
GLM_API_KEY=1234567890abcdef

# MiniMax (注意：使用 AUTH_TOKEN)
MINIMAX_AUTH_TOKEN=9876543210fedcba

# DeepSeek
DEEPSEEK_API_KEY=abcdefghijklmnopqrstuvwx

# 通义千问
QWEN_API_KEY=zyxwvutsrqponmlkji

# Claude 官方（可选）
# ANTHROPIC_API_KEY=sk-ant-xxxxx
```

### 切换平台示例

```bash
# 1. 选择平台
~/.claude-platforms/switch glm

# 2. 加载配置
source ~/.claude-platforms/config.sh glm

# 3. 验证配置
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL

# 4. 启动 Claude Code
claude
```

---

## 获取 API Keys

### 智谱 GLM
访问：https://open.bigmodel.cn/
1. 注册/登录账号
2. 进入"API Key"管理
3. 创建新的 API Key

### MiniMax
访问：https://api.minimaxi.com/
1. 注册/登录账号
2. 获取 AUTH_TOKEN（注意不是 API_KEY）

### DeepSeek
访问：https://platform.deepseek.com/
1. 注册/登录账号
2. 进入"API Keys"管理
3. 创建新的 API Key

### 通义千问
访问：https://bailian.console.aliyun.com/
1. 登录阿里云账号
2. 开通DashScope服务
3. 创建 API Key

### Claude 官方
访问：https://console.anthropic.com/
1. 登录 Anthropic 账号
2. 进入"API Keys"
3. 创建新的 API Key
