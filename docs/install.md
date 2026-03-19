# Claude Code 平台切换器 — 安装指南

## For Humans

复制这句话给你的 AI Agent：

```
帮我安装 Claude Code 平台切换器：https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/docs/install.md
```

升级（保留配置）：

```
帮我升级 Claude Code 平台切换器（保留配置）：https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/docs/install.md
```

---

## For AI Agents

### Goal

安装 Claude Code 平台切换器，让用户可以一键切换 AI 平台（智谱 GLM、MiniMax、DeepSeek、通义千问、Claude 官方）。

### ⚠️ Boundaries

- **DO NOT** 运行需要 sudo 的命令
- **DO NOT** 修改 `~/.claude-platforms/` 以外的系统文件
- **DO NOT** 在工作目录创建文件（所有文件都在 `~/.claude-platforms/`）

### 📁 目录规则

| 用途 | 目录 |
|------|------|
| 配置和脚本 | `~/.claude-platforms/` |
| Skill 文件 | `~/.claude/skills/platform-switcher/` |

### Step 1: 运行安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash
```

**如果是升级（保留配置）：**

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### Step 2: 检查安装结果

验证核心文件是否安装成功：

```bash
ls -la ~/.claude-platforms/
```

应该看到：
- `config.sh` - 配置脚本
- `switch` - 切换脚本
- `quick-switch.sh` - 一键切换脚本
- `.env` 或 `.env.example` - API Keys 配置

### Step 3: 配置 API Keys

检查 `.env` 文件是否已创建：

```bash
cat ~/.claude-platforms/.env
```

如果显示的是模板值（如 `your-actual-glm-key-here`），询问用户：

> "安装完成！现在需要配置 API Keys。请编辑 `~/.claude-platforms/.env` 文件，填入你的真实 API Keys（智谱 GLM、MiniMax 等）。配置好后告诉我，我来帮你切换平台。"

用户编辑命令：

```bash
nano ~/.claude-platforms/.env
```

需要配置的变量：

```bash
# 智谱 GLM
GLM_API_KEY=your-actual-glm-key-here

# MiniMax (注意：使用 AUTH_TOKEN)
MINIMAX_AUTH_TOKEN=your-actual-minimax-key-here

# DeepSeek
DEEPSEEK_API_KEY=your-actual-deepseek-key-here

# 通义千问
QWEN_API_KEY=your-actual-qwen-key-here
```

### Step 4: 验证安装

```bash
~/.claude-platforms/switch
```

应该显示当前平台和可用平台列表。

### Step 5: 切换平台

用户配置好 API Keys 后，帮助切换到指定平台：

```bash
~/.claude-platforms/quick-switch.sh glm
```

然后提示用户：

> "已切换到智谱 GLM。请按 Ctrl+D 退出当前会话，然后执行 `claude` 启动新会话。"

---

## Quick Reference

| 命令 | 作用 |
|------|------|
| `~/.claude-platforms/switch` | 查看当前平台 |
| `~/.claude-platforms/switch glm` | 切换到智谱 GLM |
| `~/.claude-platforms/quick-switch.sh glm` | 一键切换 + 显示指导 |
| `source ~/.claude-platforms/config.sh glm` | 加载 GLM 配置到当前 shell |

## 支持的平台

| 平台 | 命令 | 特点 |
|------|------|------|
| 智谱 GLM | `glm` | 性价比高，三层模型 |
| MiniMax | `minimax` | 超长上下文，50分钟超时 |
| DeepSeek | `deepseek` | 响应快 |
| 通义千问 | `qwen` | 稳定可靠 |
| Claude 官方 | `claude` | 最新功能 |

## 常见问题

### .env 文件不存在？

```bash
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env
chmod 600 ~/.claude-platforms/.env
nano ~/.claude-platforms/.env
```

### API Key 未设置？

检查 `.env` 文件中的变量名是否正确，确保没有多余空格。

### 切换后不生效？

```bash
source ~/.claude-platforms/config.sh <平台>
```

---

**GitHub**: https://github.com/pwl1987/claude-platform-switcher
