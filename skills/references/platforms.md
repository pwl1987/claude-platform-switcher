# 支持的 AI 平台

本文档详细介绍了 Claude Code 平台切换器支持的所有 AI 平台。

## MiniMax

### 基本信息
- **BASE_URL**: `https://api.minimaxi.com/anthropic`
- **认证方式**: `ANTHROPIC_AUTH_TOKEN`（注意：不同于其他平台的 API_KEY）
- **适用场景**: 复杂任务、长时间会话

### 模型配置
```bash
export ANTHROPIC_MODEL="MiniMax-M2.7"
export ANTHROPIC_SMALL_FAST_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
```

### 特色配置
- **超时时间**: 3000000ms (50分钟) - 适合超长上下文任务
- **路径**: `/anthropic` - 专用的 Anthropic 兼容端点

### 使用建议
- ✅ 复杂编程任务
- ✅ 长时间会话
- ✅ 大文件分析
- ❌ 快速查询（用其他平台更快）

---

## 智谱 GLM

### 基本信息
- **BASE_URL**: `https://open.bigmodel.cn/api/paas/v4`
- **认证方式**: `ANTHROPIC_API_KEY`
- **适用场景**: 日常使用、平衡性能

### 模型配置（三层模型映射）
```bash
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"  # 快速任务
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"     # 日常使用
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"         # 复杂任务
```

### 模型说明
- **glm-4.5-air (Haiku)**: 轻量快速，适合简单查询
- **glm-4.7 (Sonnet)**: 日常使用的平衡选择
- **glm-5 (Opus)**: 最强模型，适合复杂任务

### 使用建议
- ✅ 日常开发
- ✅ 成本优化
- ✅ 中文任务优化
- ✅ 三层模型灵活选择

---

## DeepSeek

### 基本信息
- **BASE_URL**: `https://api.deepseek.com`
- **认证方式**: `ANTHROPIC_API_KEY`
- **适用场景**: 快速响应、简单任务

### 模型配置
```bash
export ANTHROPIC_MODEL="deepseek-chat"
```

### 特色
- 响应速度快
- 性价比高
- 适合简单任务

### 使用建议
- ✅ 快速问答
- ✅ 简单代码生成
- ✅ 成本敏感场景
- ❌ 复杂推理（建议用 GLM-5 或 MiniMax）

---

## 通义千问

### 基本信息
- **BASE_URL**: `https://dashscope.aliyuncs.com/compatible-mode/v1`
- **认证方式**: `ANTHROPIC_API_KEY`
- **适用场景**: 企业应用、稳定可靠

### 模型配置
```bash
export ANTHROPIC_MODEL="qwen-plus"
```

### 特色
- 阿里云基础设施
- 稳定可靠
- 企业级支持

### 使用建议
- ✅ 企业环境
- ✅ 生产环境
- ✅ 需要稳定性的场景
- ✅ 阿里云用户

---

## Claude 官方

### 基本信息
- 无需配置 BASE_URL
- 使用官方 API 端点
- 原生 Claude 模型

### 使用方式
```bash
switch claude  # 清除所有自定义配置，恢复默认
```

### 特色
- 最稳定
- 最新模型
- 官方支持

### 使用建议
- ✅ 生产环境
- ✅ 重要任务
- ✅ 需要最新功能
- ❌ 成本敏感场景

---

## 平台选择建议

| 场景 | 推荐平台 | 原因 |
|------|---------|------|
| 日常开发 | 智谱 GLM (Sonnet) | 性价比高，三层模型灵活 |
| 复杂编程 | MiniMax | 超长上下文，50分钟超时 |
| 快速查询 | DeepSeek | 响应快 |
| 企业应用 | 通义千问 | 稳定可靠 |
| 生产环境 | Claude 官方 | 最稳定 |
| 成本优化 | 智谱 GLM | 国产平台价格优势 |

---

## 配置文件示例

### MiniMax 配置
```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="your-minimax-api-key-here"
export API_TIMEOUT_MS="3000000"
export ANTHROPIC_MODEL="MiniMax-M2.7"
```

### 智谱 GLM 配置
```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="your-glm-api-key-here"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"
```

### DeepSeek 配置
```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="your-deepseek-api-key-here"
export ANTHROPIC_MODEL="deepseek-chat"
```

### 通义千问配置
```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export ANTHROPIC_API_KEY="your-dashscope-api-key-here"
export ANTHROPIC_MODEL="qwen-plus"
```

### Claude 官方配置（恢复默认）
```bash
#!/bin/bash
# 清除所有自定义配置
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_API_KEY
unset ANTHROPIC_AUTH_TOKEN
unset ANTHROPIC_MODEL
```
