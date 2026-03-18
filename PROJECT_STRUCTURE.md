# 项目目录结构

## 概述

Claude Code 平台切换器 - 一个极简的工具，用于在不同的 AI 平台之间快速切换。

## 目录结构

```
claude-platform-switcher/
├── README.md                   # 项目主文档
├── QUICKSTART.md               # 快速开始指南
├── USAGE.md                    # 使用指南
├── PRD.md                      # 产品需求文档
├── LICENSE                     # MIT 许可证
├── IMPLEMENTATION_SUMMARY.md   # 实施总结
│
├── switch                      # 核心切换脚本
├── install.sh                  # 一键安装脚本
├── verify.sh                   # 验证测试脚本
├── example.sh                  # 示例配置文件
│
├── config-minimax.sh           # MiniMax 配置
├── config-glm.sh               # 智谱 GLM 配置
├── config-deepseek.sh          # DeepSeek 配置
├── config-qwen.sh              # 通义千问配置
├── config-claude.sh            # Claude 官方配置
├── current                     # 当前平台软链接（动态生成）
│
├── skills/                     # Claude Code Skills（版本管理）
│   └── platform-switcher/      # 平台切换器 Skill
│       ├── SKILL.md            # 主技能文件
│       ├── README.md           # Skill 使用说明
│       ├── skill-plan.md       # 创建计划
│       ├── scripts/            # 辅助脚本
│       │   ├── switch_and_restart.sh
│       │   ├── save_context.sh
│       │   ├── restore_context.sh
│       │   └── get_current_platform.sh
│       └── references/         # 参考文档
│           ├── platforms.md    # 平台详情
│           └── usage.md        # 使用指南
│
├── .git/                       # Git 版本控制
├── .gitignore                  # Git 忽略规则
│
└── .claude/                    # Claude Code 本地配置（不提交）
    └── skills/                 # 其他 skills（不提交）
        └── platform-switcher/  # Skill 的本地副本（不提交）
```

## 文件说明

### 核心脚本

- **switch** - 主切换脚本，用于在不同平台之间切换
- **install.sh** - 一键安装脚本，自动配置环境
- **verify.sh** - 自动化测试脚本，验证配置正确性

### 配置文件

- **config-*.sh** - 各平台的配置文件
  - `config-minimax.sh` - MiniMax 配置（超长上下文）
  - `config-glm.sh` - 智谱 GLM 配置（三层模型）
  - `config-deepseek.sh` - DeepSeek 配置（快速响应）
  - `config-qwen.sh` - 通义千问配置（企业稳定）
  - `config-claude.sh` - Claude 官方配置（恢复默认）

### 文档

- **README.md** - 项目主文档，包含完整的使用说明
- **QUICKSTART.md** - 5 分钟快速上手指南
- **USAGE.md** - 详细使用指南和最佳实践
- **PRD.md** - 完整的产品需求文档（14章节）
- **IMPLEMENTATION_SUMMARY.md** - 项目实施总结

### Skills 目录

**重要**: `skills/` 目录包含版本管理的 Claude Code Skills

- **platform-switcher/** - 将项目转换为 Claude Code Skill
  - 支持在 Claude Code 中直接调用切换平台
  - 自动保存和恢复会话上下文
  - 智能平台推荐

### .gitignore

排除以下内容：

- `current` - 动态生成的软链接
- `config-*.local.sh` - 包含 API Keys 的本地配置
- `_bmad/` - 生成的工作目录
- `_bmad-output/` - 生成的工作输出
- `design-artifacts/` - 设计文件
- `.claude/skills/` - 本地 skills（大部分不提交）
- `.claude/memory/` - Claude Code 内存

**保留**：
- `.claude/skills/platform-switcher/` - 重要的 platform-switcher skill

## 安装位置

### 开发目录（本项目）

```
/data/Code/skill/claude-platform-switcher/
```

### 安装目录（使用位置）

```bash
~/.claude-platforms/
```

安装脚本会将以下文件复制到 `~/.claude-platforms/`：

- `switch` - 切换脚本
- `config-*.sh` - 平台配置文件
- `install.sh` - 安装脚本
- `verify.sh` - 验证脚本

## 使用流程

### 1. 安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/master/install.sh | bash
```

### 2. 配置

编辑配置文件，填入 API Keys：

```bash
nano ~/.claude-platforms/config-glm.sh
```

### 3. 使用

```bash
# 切换平台
switch glm

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

### 4. Skill 使用（可选）

如果安装了 skill，可以直接在 Claude Code 中说：

```
切换到智谱 GLM
```

## 版本管理

### 项目代码

项目本体在 GitHub 上进行版本管理：

```
https://github.com/pwl1987/claude-platform-switcher
```

### Skill 文件

Skill 文件位于 `skills/` 目录，随项目一起版本管理：

```
skills/platform-switcher/
```

安装时需要复制到：

```
~/.claude/skills/platform-switcher/
```

## 贡献指南

欢迎提交 Issue 和 Pull Request！

### 添加新平台

1. 在项目根目录创建 `config-新平台.sh`
2. 在 `skills/platform-switcher/references/platforms.md` 中添加文档
3. 在 `skills/platform-switcher/SKILL.md` 中更新触发条件
4. 提交 Pull Request

### 改进文档

文档位于项目根目录和 `skills/platform-switcher/` 目录。

欢迎改进：
- README.md - 主文档
- USAGE.md - 使用指南
- PRD.md - 产品需求文档
- skills/platform-switcher/README.md - Skill 使用说明

## 许可证

MIT License - 详见 LICENSE 文件

---

**Made with ❤️ for Claude Code users**
