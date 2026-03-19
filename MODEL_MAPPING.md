# Claude Code 平台模型映射配置参考

本文档列出了各个平台在 `settings.json` 中的完整环境变量配置。

---

## 智谱 GLM (BigModel)

**特点**: 三层模型映射，按需调用，性价比高

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "your_zhipu_api_key",
    "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5"
  }
}
```

**模型说明**:
| Claude 层级 | GLM 模型 | 用途 |
|------------|---------|------|
| Haiku | glm-4.5-air | 快速任务、简单查询 |
| Sonnet | glm-4.7 | 日常开发、代码分析 |
| Opus | glm-5 | 复杂任务、长上下文 |

---

## MiniMax

**特点**: 统一模型，超长上下文支持，50分钟超时

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "your_minimax_api_key",
    "API_TIMEOUT_MS": "3000000",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
    "ANTHROPIC_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_SMALL_FAST_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.7",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2.7"
  }
}
```

**模型说明**:
- 所有层级统一使用 `MiniMax-M2.7`
- `API_TIMEOUT_MS: 3000000` = 50分钟超时
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC: 1` = 禁用非必要流量

---

## DeepSeek

**特点**: 快速响应，适合简单任务

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com",
    "ANTHROPIC_API_KEY": "your_deepseek_api_key",
    "ANTHROPIC_MODEL": "deepseek-chat",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-chat",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-chat",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-chat"
  }
}
```

**模型说明**:
- 所有层级统一使用 `deepseek-chat`
- 还可选 `deepseek-coder`（纯代码模型）

---

## 通义千问 (Qwen/阿里云)

**特点**: 稳定可靠，适合企业应用

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://dashscope.aliyuncs.com/compatible-mode/v1",
    "ANTHROPIC_API_KEY": "your_qwen_api_key",
    "ANTHROPIC_MODEL": "qwen-plus",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "qwen-turbo",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "qwen-plus",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "qwen-max"
  }
}
```

**模型说明**:
| Claude 层级 | Qwen 模型 | 用途 |
|------------|---------|------|
| Haiku | qwen-turbo | 快速响应 |
| Sonnet | qwen-plus | 日常开发 |
| Opus | qwen-max | 复杂任务 |

**可选模型**:
- `qwen-turbo` - 快速轻量
- `qwen-plus` - 均衡性能
- `qwen-max` - 最强能力
- `qwq-32b-preview` - 推理专用

---

## Claude 官方 (Anthropic)

**特点**: 原生支持，最新功能，无自定义配置

```json
{
  "env": {
    // 清空所有自定义环境变量，使用 Claude Code 默认配置
  }
}
```

**或者显式设置**（一般不需要）:
```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.anthropic.com",
    "ANTHROPIC_MODEL": "claude-sonnet-4-6-20250514",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku-4-5-20250731",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-6-20250514",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-6-20250514"
  }
}
```

**官方模型 (2025)**:
| 层级 | 模型名称 |
|------|---------|
| Haiku | claude-haiku-4-5-20250731 |
| Sonnet | claude-sonnet-4-6-20250514 |
| Opus | claude-opus-4-6-20250514 |

---

## 平台对比速查表

| 平台 | Haiku | Sonnet | Opus | 超时 | 特点 |
|------|-------|--------|------|------|------|
| **GLM** | glm-4.5-air | glm-4.7 | glm-5 | 50min | 三层映射，性价比 |
| **MiniMax** | M2.7 | M2.7 | M2.7 | 50min | 超长上下文 |
| **DeepSeek** | chat | chat | chat | 默认 | 快速响应 |
| **Qwen** | turbo | plus | max | 默认 | 稳定可靠 |
| **Claude** | haiku-4.5 | sonnet-4.6 | opus-4.6 | 默认 | 最新功能 |

---

## 环境变量说明

### 通用变量

| 变量名 | 说明 | 示例 |
|--------|------|------|
| `ANTHROPIC_BASE_URL` | API 端点 | `https://api.example.com/v1` |
| `ANTHROPIC_API_KEY` | API 密钥 | `sk-xxxxx` |
| `ANTHROPIC_AUTH_TOKEN` | 认证令牌（部分平台） | `Bearer xxxx` |
| `API_TIMEOUT_MS` | 请求超时（毫秒） | `3000000` |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | 禁用非必要流量 | `1` |

### 模型映射变量

| 变量名 | 说明 |
|--------|------|
| `ANTHROPIC_MODEL` | 默认模型（未指定层级时使用） |
| `ANTHROPIC_SMALL_FAST_MODEL` | 快速小模型 |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | Haiku 层级映射 |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | Sonnet 层级映射 |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | Opus 层级映射 |

---

## 配置文件位置

- **全局配置**: `~/.claude/settings.json`
- **项目配置**: `<project>/.claude/settings.json`
- **项目本地配置**: `<project>/.claude/settings.local.json`（优先级最高）

**注意**: 项目配置会覆盖全局配置。

---

## 快捷切换

使用本项目的切换脚本：

```bash
# 快捷切换（推荐）
~/.claude-platforms/quick-switch.sh glm
~/.claude-platforms/quick-switch.sh minimax
~/.claude-platforms/quick-switch.sh deepseek
~/.claude-platforms/quick-switch.sh qwen
~/.claude-platforms/quick-switch.sh claude
```

或在 Claude Code 中使用斜杠命令：

```
/sw:glm
/sw:minimax
/sw:deepseek
/sw:qwen
/sw:claude
```

API Key 配置：

```
/sw:setkey         # 交互式配置
/sw:key-glm        # 配置智谱 GLM
/sw:key-minimax    # 配置 MiniMax
/sw:key-deepseek   # 配置 DeepSeek
/sw:key-qwen       # 配置通义千问
/sw:key-claude     # 配置 Claude
```
