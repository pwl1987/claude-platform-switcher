# Claude Code 平台切换器

> 💡 **一句话介绍**：一个命令切换 AI 平台，省钱又稳定

**痛点**：Claude 官方 API 太贵？国内访问不稳定？想用国产平替但切换太麻烦？

**解决方案**：一键切换，立即生效，省钱 90%+

---

## ⚡ 5 秒快速上手

### 1. 安装

```bash
git clone https://github.com/pwl1987/claude-platform-switcher.git
cd claude-platform-switcher
cp -r .claude/skills/platform-switcher ~/.claude/skills/
cp -r config-*.sh switch ~/.claude-platforms/
```

### 2. 配置 API Keys

```bash
# 复制环境变量模板
cp .env.example ~/.claude-platforms/.env

# 编辑并填入你的真实 API Keys
nano ~/.claude-platforms/.env
```

填入你的 API Keys：

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

### 3. 设置文件权限（安全）

```bash
chmod 600 ~/.claude-platforms/.env
```

### 4. 享受切换

```bash
# 在 Claude Code 中直接说
切换到智谱 GLM
```

或者使用命令：

```bash
# 切换到智谱 GLM
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

**就这么简单！** 🎉

---

## 🎯 支持的平台

| 平台 | 特点 | 适用场景 |
|------|------|----------|
| **智谱 GLM** | 性价比高，三层模型 | 日常开发、编程任务 |
| **MiniMax** | 超长上下文，50分钟超时 | 复杂任务、长代码分析 |
| **DeepSeek** | 响应快 | 快速查询、简单问答 |
| **通义千问** | 稳定可靠 | 企业环境、重要任务 |
| **Claude 官方** | 最新功能 | 质量优先、测试新特性 |

---

## 🚀 使用方法

### 方式 1：使用 Skill（推荐）

在 Claude Code 中直接说：

```
切换到智谱 GLM
```

```
当前用的是什么平台？
```

```
这个任务用哪个平台比较好？
```

### 方式 2：命令行切换

```bash
# 切换平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

### 方式 3：快捷命令

在 `~/.bashrc` 中添加：

```bash
# Claude Code 快捷启动
alias cc='source ~/.claude-platforms/current && claude'

# 各平台快捷启动
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

## 💡 使用技巧

### 根据任务自动选择平台

| 任务类型 | 推荐平台 | 命令 |
|---------|---------|------|
| 日常编程 | 智谱 GLM | `switch glm` |
| 复杂重构 | MiniMax | `switch minimax` |
| 快速问答 | DeepSeek | `switch deepseek` |
| 重要任务 | 通义千问 | `switch qwen` |
| 测试新功能 | Claude 官方 | `switch claude` |

### 查看当前平台

```bash
~/.claude-platforms/switch
```

输出：

```
🔄 Claude Code 平台切换器

当前平台:
  ✅ glm

可用平台:
  - deepseek
  - glm
  - minimax
  - qwen
  - claude
```

---

## 🔧 配置说明

所有平台配置都从 `~/.claude-platforms/.env` 文件读取 API Keys，确保安全。

### 智谱 GLM（推荐日常使用）

```bash
~/.claude-platforms/config-glm.sh
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="$GLM_API_KEY"

# 三层模型映射
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"
```

### MiniMax（复杂任务）

```bash
~/.claude-platforms/config-minimax.sh
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="$MINIMAX_AUTH_TOKEN"
export API_TIMEOUT_MS="3000000"

# 统一模型
export ANTHROPIC_MODEL="MiniMax-M2.7"
```

### DeepSeek（快速查询）

```bash
~/.claude-platforms/config-deepseek.sh
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY"
export ANTHROPIC_MODEL="deepseek-chat"
```

### 通义千问（稳定可靠）

```bash
~/.claude-platforms/config-qwen.sh
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export ANTHROPIC_API_KEY="$QWEN_API_KEY"
export ANTHROPIC_MODEL="qwen-plus"
```

### Claude 官方（测试新功能）

```bash
~/.claude-platforms/config-claude.sh
```

配置：
```bash
# 清除所有自定义配置，恢复使用 Claude 官方 API
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_API_KEY
```

---

## 📖 工作原理

```
┌─────────────────┐
│  switch glm     │  执行切换
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  config-glm.sh  │  读取配置
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  .env 文件      │  加载环境变量
│  GLM_API_KEY=...│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  导出环境变量    │  设置到当前 shell
└─────────────────┘
```

### 核心机制

1. **切换**：修改 `current` 软链接指向目标平台
2. **加载**：从 `.env` 文件读取 API Keys（安全）
3. **配置**：设置环境变量到当前 shell
4. **启动**：Claude Code 自动读取环境变量

---

## 🔒 安全保证

### .env 不会被提交

✅ `.env` 已加入 `.gitignore`，不会提交到 GitHub
✅ 文件权限设置为 `600`，只有你可以读取
✅ 所有配置脚本从 `.env` 读取 API Keys

### 验证安全性

```bash
# 检查 .gitignore
cat .gitignore | grep .env

# 检查文件权限
ls -la ~/.claude-platforms/.env

# 应该显示：-rw------- (600)
```

---

## ❓ 常见问题

### Q: 提示 ".env 文件不存在"？

**A**: 创建 `.env` 文件：

```bash
cp .env.example ~/.claude-platforms/.env
nano ~/.claude-platforms/.env
```

### Q: 提示 "GLM_API_KEY 未设置"？

**A**: 检查 `.env` 文件：

```bash
# 检查文件是否存在
ls -la ~/.claude-platforms/.env

# 检查变量名是否正确
grep GLM_API_KEY ~/.claude-platforms/.env

# 确保没有多余的空格或引号
# 正确：GLM_API_KEY=your-key
# 错误：GLM_API_KEY = your-key
# 错误：GLM_API_KEY="your-key"
```

### Q: 切换后不生效？

**A**: 执行 `source ~/.claude-platforms/current` 重新加载配置。

### Q: 如何查看当前使用的平台？

**A**: 执行 `~/.claude-platforms/switch` 命令。

### Q: 支持 Windows 吗？

**A**: 支持 WSL（Windows Subsystem for Linux）。

---

## 📊 成本对比

| 平台 | 价格（相对） | 月费用（估算） |
|------|------------|---------------|
| Claude 官方 | 100% | $100 |
| 智谱 GLM | 10% | $10 |
| MiniMax | 5% | $5 |
| DeepSeek | 3% | $3 |
| 通义千问 | 8% | $8 |

**使用国产平台，每月可节省 90%+ 的成本！** 💰

---

## 🎁 更多功能

### 添加新平台

创建配置文件：

```bash
cat > ~/.claude-platforms/config-新平台.sh << 'EOF'
#!/bin/bash

# 检查 .env 文件是否存在
if [ ! -f "$HOME/.claude-platforms/.env" ]; then
    echo "⚠️  警告: 未找到 .env 文件"
    exit 1
fi

# 加载 .env 文件
export $(grep -v '^#' "$HOME/.claude-platforms/.env" | xargs)

# 检查必要的环境变量是否设置
if [ -z "$NEW_PLATFORM_API_KEY" ]; then
    echo "❌ 错误: NEW_PLATFORM_API_KEY 未在 .env 中设置"
    exit 1
fi

# 新平台配置
export ANTHROPIC_BASE_URL="https://api.example.com/v1"
export ANTHROPIC_API_KEY="$NEW_PLATFORM_API_KEY"
export ANTHROPIC_MODEL="model-name"
EOF

chmod +x ~/.claude-platforms/config-新平台.sh
```

在 `.env` 文件中添加：

```bash
NEW_PLATFORM_API_KEY=your-api-key
```

然后使用 `~/.claude-platforms/switch 新平台` 即可。

---

## 🔗 相关链接

- [GitHub 仓库](https://github.com/pwl1987/claude-platform-switcher)
- [Claude Code 文档](https://docs.anthropic.com/claude-code)
- [提交问题](https://github.com/pwl1987/claude-platform-switcher/issues)

---

## 📝 更新日志

### v2.0.0 (2026-03-18)
- ✅ 使用 `.env` 管理 API Keys，提升安全性
- ✅ 添加 Claude Code Skill 支持
- ✅ 优化文档，突出个人使用场景
- ✅ 完善模型映射和平台配置

### v1.0.0 (2026-03-18)
- ✅ 初始版本发布
- ✅ 支持 5 个主流平台
- ✅ 一键安装脚本

---

**Made with ❤️ for 个人开发者**

> 💬 **反馈**：遇到问题或有建议？欢迎提 [Issue](https://github.com/pwl1987/claude-platform-switcher/issues)
