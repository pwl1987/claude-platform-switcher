# Claude Code AI 平台切换器

> 💡 **一句话介绍**：一个命令切换 AI 平台，省钱又稳定

**痛点**：Claude 官方 API 太贵？国内访问不稳定？想用国产平替但切换太麻烦？

**解决方案**：一键切换，立即生效，省钱 90%+

---

## 🤖 AI 自动安装（推荐）

只需对 Claude Code 说一句话：

```
帮我安装 Claude Code 平台切换器：https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/docs/install.md
```

升级（保留配置）：

```
帮我升级 Claude Code 平台切换器：https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/docs/update.md
```

---

## 🚀 一键安装

### 新安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash
```

### 升级（保留配置）

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### 强制重新安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --force
```

---

## ⚡ 5 秒快速上手

### 1. 安装

**方式 A: 一键安装（推荐）**

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash
```

**方式 B: 手动安装**

```bash
git clone https://github.com/pwl1987/claude-platform-switcher.git
cd claude-platform-switcher

# 复制文件到 ~/.claude-platforms/
cp config.sh switch ~/.claude-platforms/
cp -r scripts ~/.claude-platforms/
cp .env.example ~/.claude-platforms/.env
```

### 2. 配置 API Keys

```bash
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
# 切换到智谱 GLM
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/config.sh glm

# 启动 Claude Code
claude
```

**就这么简单！** 🎉

---

## 🎯 支持的平台

| 平台 | 命令 | 特点 | 适用场景 |
|------|------|------|----------|
| **智谱 GLM** | `glm` | 性价比高，三层模型 | 日常开发、编程任务 |
| **MiniMax** | `minimax` | 超长上下文，50分钟超时 | 复杂任务、长代码分析 |
| **DeepSeek** | `deepseek` | 响应快 | 快速查询、简单问答 |
| **通义千问** | `qwen` | 稳定可靠 | 企业环境、重要任务 |
| **Claude 官方** | `claude` | 最新功能 | 质量优先、测试新特性 |

---

## 🚀 使用方法

### 方式 1：快速切换（推荐）

使用一键切换脚本：

```bash
~/.claude-platforms/quick-switch.sh glm
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

### 方式 2：使用 Skill（自然语言）

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

### 方式 3：命令行切换（手动）

```bash
# 切换平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/config.sh glm

# 启动 Claude Code
claude
```

### 方式 4：快捷命令

在 `~/.bashrc` 中添加：

```bash
# Claude Code 快捷启动
alias cc='source ~/.claude-platforms/config.sh $(cat ~/.claude-platforms/.current 2>/dev/null || echo "glm") && claude'

# 各平台快捷启动
alias cc-glm='~/.claude-platforms/switch glm && source ~/.claude-platforms/config.sh glm && claude'
alias cc-minimax='~/.claude-platforms/switch minimax && source ~/.claude-platforms/config.sh minimax && claude'
alias cc-deepseek='~/.claude-platforms/switch deepseek && source ~/.claude-platforms/config.sh deepseek && claude'
alias cc-qwen='~/.claude-platforms/switch qwen && source ~/.claude-platforms/config.sh qwen && claude'
alias cc-claude='~/.claude-platforms/switch claude && source ~/.claude-platforms/config.sh claude && claude'
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
  - glm      智谱 GLM（三层模型，性价比高）
  - minimax  MiniMax（超长上下文，50分钟超时）
  - deepseek DeepSeek（快速响应）
  - qwen     通义千问（稳定可靠）
  - claude   Claude 官方（最新功能）
```

---

## 🔧 配置说明

### config.sh - 统一配置脚本

所有平台配置都通过 `config.sh` 统一管理，从 `~/.claude-platforms/.env` 文件读取 API Keys。

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

### 智谱 GLM（推荐日常使用）

```bash
source ~/.claude-platforms/config.sh glm
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"
export ANTHROPIC_API_KEY="$GLM_API_KEY"

# 三层模型映射
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-5"
```

### MiniMax（复杂任务）

```bash
source ~/.claude-platforms/config.sh minimax
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
source ~/.claude-platforms/config.sh deepseek
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com"
export ANTHROPIC_API_KEY="$DEEPSEEK_API_KEY"
export ANTHROPIC_MODEL="deepseek-chat"
```

### 通义千问（稳定可靠）

```bash
source ~/.claude-platforms/config.sh qwen
```

配置：
```bash
export ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export ANTHROPIC_API_KEY="$QWEN_API_KEY"
export ANTHROPIC_MODEL="qwen-plus"
```

### Claude 官方（测试新功能）

```bash
source ~/.claude-platforms/config.sh claude
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
│  保存 .current  │  记录平台选择
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  config.sh glm  │  加载配置
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  .env 文件      │  读取 API Keys
│  GLM_API_KEY=...│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  导出环境变量    │  设置到当前 shell
└─────────────────┘
```

### 核心机制

1. **切换**：保存平台选择到 `~/.claude-platforms/.current`
2. **加载**：从 `.env` 文件读取 API Keys（安全）
3. **配置**：根据平台参数设置环境变量
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

**A**: 执行 `source ~/.claude-platforms/config.sh <平台>` 重新加载配置。

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

在 `config.sh` 中添加新的配置函数：

```bash
# 配置新平台
config_newplatform() {
    if [ -z "$NEWPLATFORM_API_KEY" ]; then
        echo -e "${RED}❌ 错误: NEWPLATFORM_API_KEY 未在 .env 中设置${NC}"
        exit 1
    fi

    export ANTHROPIC_BASE_URL="https://api.example.com/v1"
    export ANTHROPIC_API_KEY="$NEWPLATFORM_API_KEY"
    export ANTHROPIC_MODEL="model-name"

    echo -e "${GREEN}✅ 已切换到新平台${NC}"
}
```

在 `.env` 文件中添加：

```bash
NEWPLATFORM_API_KEY=your-api-key
```

然后使用 `source ~/.claude-platforms/config.sh newplatform` 即可。

---

## 📁 项目结构

```
claude-platform-switcher/
├── SKILL.md              # Claude Code Skill 定义
├── README.md             # 本文件
├── config.sh             # 统一配置脚本
├── switch                # 平台切换脚本
├── .env.example          # 环境变量模板
├── .gitignore            # Git 忽略规则
├── LICENSE               # 许可证
├── scripts/              # 辅助脚本
│   ├── save_context.sh
│   ├── restore_context.sh
│   └── get_current_platform.sh
└── references/           # 参考文档
    ├── platforms.md
    └── usage.md
```

---

## 🔗 相关链接

- [GitHub 仓库](https://github.com/pwl1987/claude-platform-switcher)
- [Claude Code 文档](https://docs.anthropic.com/claude-code)
- [提交问题](https://github.com/pwl1987/claude-platform-switcher/issues)

---

## 📝 更新日志

### v3.2.0 (2026-03-19)
- ✅ 新增 `docs/install.md` - AI Agent 自动安装指南
- ✅ 新增 `docs/update.md` - AI Agent 自动升级指南（保留配置）
- ✅ 安装和升级文档分离，用户体验更清晰

### v3.1.0 (2026-03-19)
- ✅ 新增一键安装/升级脚本 `install.sh`
- ✅ 支持从 GitHub 直接安装
- ✅ 升级时自动保留 `.env` 配置
- ✅ 添加版本号文件 `VERSION`

### v3.0.0 (2026-03-18)
- ✅ 合并平台配置脚本为单一的 config.sh
- ✅ 将 skill 目录提升到项目根目录
- ✅ 简化项目结构，提升可维护性
- ✅ 优化文档，突出个人使用场景

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
