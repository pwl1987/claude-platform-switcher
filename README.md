# Claude Code 平台切换器

> 💡 **一句话介绍**：一个命令切换 AI 平台，省钱又稳定

**痛点**：Claude 官方 API 太贵？国内访问不稳定？想用国产平替但切换太麻烦？

**解决方案**：一键切换，立即生效，省钱 90%

---

## ⚡ 5 秒快速上手

### 1. 安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/master/install.sh | bash
```

### 2. 配置一次

编辑配置文件（填入你的 API Keys）：

```bash
nano ~/.claude-platforms/config-glm.sh
```

把 `your-api-key-here` 替换成你的真实 API Key。

### 3. 享受切换

```bash
# 切换到智谱 GLM
switch glm

# 启动 Claude Code
cc
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

## 🚀 日常使用（最常用）

### 方式 1：快捷命令（推荐）

在 `~/.bashrc` 中添加：

```bash
# Claude Code 快捷启动
alias cc='source ~/.claude-platforms/current && claude'
```

然后：

```bash
# 切换平台
switch glm

# 启动 Claude Code
cc
```

### 方式 2：使用 Skill（更简单）

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

### 方式 3：手动加载

```bash
# 切换
switch glm

# 加载配置
source ~/.claude-platforms/current

# 启动
claude
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

### 创建平台启动快捷键

在 `~/.bashrc` 中添加：

```bash
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

### 查看当前平台

```bash
switch
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
```

---

## 🔧 配置说明

### 智谱 GLM（推荐日常使用）

```bash
nano ~/.claude-platforms/config-glm.sh
```

```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/paas/v4"
export ANTHROPIC_API_KEY="your-glm-api-key-here"

# 三层模型映射
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"
```

### MiniMax（复杂任务）

```bash
nano ~/.claude-platforms/config-minimax.sh
```

```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="your-minimax-api-key-here"
export API_TIMEOUT_MS="3000000"

# 统一模型
export ANTHROPIC_MODEL="MiniMax-M2.7"
```

### DeepSeek（快速查询）

```bash
nano ~/.claude-platforms/config-deepseek.sh
```

```bash
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="your-deepseek-api-key-here"
export ANTHROPIC_MODEL="deepseek-chat"
```

---

## ❓ 常见问题

### Q: 切换后不生效？

**A**: 执行 `source ~/.claude-platforms/current` 重新加载配置。

### Q: 如何查看当前使用的平台？

**A**: 执行 `switch` 命令。

### Q: 忘记重新加载配置怎么办？

**A**: 使用快捷命令 `cc`，它会自动加载配置并启动。

### Q: 支持 Windows 吗？

**A**: 支持 WSL（Windows Subsystem for Linux）。

---

## 📖 工作原理

```
┌─────────────┐
│  switch glm │  切换软链接
└──────┬──────┘
       │
       ▼
┌─────────────────┐
│ current -> glm  │  软链接指向
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│ source current │  加载环境变量
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│   claude        │  启动应用
└─────────────────┘
```

1. **切换**：修改 `current` 软链接指向目标平台
2. **加载**：通过 `source` 读取环境变量
3. **启动**：Claude Code 自动读取环境变量

---

## 🎁 更多功能

### 添加新平台

创建配置文件：

```bash
cat > ~/.claude-platforms/config-新平台.sh << 'EOF'
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.example.com/v1"
export ANTHROPIC_API_KEY="your-api-key"
export ANTHROPIC_MODEL="model-name"
EOF
```

然后使用 `switch 新平台` 即可。

### 验证配置

```bash
~/.claude-platforms/verify.sh
```

### 完整文档

- [使用指南](USAGE.md)
- [快速开始](QUICKSTART.md)
- [项目结构](PROJECT_STRUCTURE.md)

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

## 🔗 相关链接

- [GitHub 仓库](https://github.com/pwl1987/claude-platform-switcher)
- [Claude Code 文档](https://docs.anthropic.com/claude-code)
- [提交问题](https://github.com/pwl1987/claude-platform-switcher/issues)

---

## 📝 更新日志

### v1.1.0 (2026-03-18)
- ✅ 添加 Claude Code Skill 支持
- ✅ 优化文档，突出个人使用场景
- ✅ 添加快捷命令和使用技巧
- ✅ 完善模型映射和平台配置

### v1.0.0 (2026-03-18)
- ✅ 初始版本发布
- ✅ 支持 5 个主流平台
- ✅ 一键安装脚本

---

**Made with ❤️ for 个人开发者**

> 💬 **反馈**：遇到问题或有建议？欢迎提 [Issue](https://github.com/pwl1987/claude-platform-switcher/issues)
