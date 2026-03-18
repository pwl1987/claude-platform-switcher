# Skills 目录

本目录包含 **Claude Code Skills**，用于扩展 Claude Code 的功能。

## platform-switcher Skill

`platform-switcher/` 是将 claude-platform-switcher 项目转换为 Claude Code Skill。

### 功能

- ✅ 在 Claude Code 中直接切换 AI 平台
- ✅ 自动保存会话上下文
- ✅ 重启后自动恢复工作进度
- ✅ 智能平台推荐

### 使用方法

#### 安装 Skill

```bash
# 复制到 Claude Code skills 目录
cp -r skills/platform-switcher ~/.claude/skills/

# 或解压 zip 文件
unzip skills/platform-switcher.zip -d ~/.claude/skills/
```

#### 在 Claude Code 中使用

重新启动 Claude Code，然后直接对话：

```
切换到智谱 GLM
```

或

```
使用 MiniMax 完成这个任务
```

或

```
当前用的是什么平台？
```

### 文件结构

```
platform-switcher/
├── SKILL.md              # 主技能文件（核心）
├── README.md             # 使用说明
├── skill-plan.md         # 创建计划
├── scripts/              # 辅助脚本
│   ├── switch_and_restart.sh   # 切换并重启
│   ├── save_context.sh         # 保存上下文
│   ├── restore_context.sh      # 恢复上下文
│   └── get_current_platform.sh # 获取当前平台
└── references/           # 参考文档
    ├── platforms.md      # 平台详情
    └── usage.md          # 使用指南
```

### 触发条件

Skill 在以下情况自动触发：

- **明确切换**："切换到智谱 GLM"、"使用 MiniMax"
- **询问当前**："当前用的是什么平台？"
- **请求推荐**："这个任务用哪个平台比较好？"

### 支持的平台

| 平台 | 命令 | 特点 |
|------|------|------|
| 智谱 GLM | `glm` | 三层模型映射（4.5-air/4.7/5） |
| MiniMax | `minimax` | 超长上下文，50分钟超时 |
| DeepSeek | `deepseek` | 快速响应 |
| 通义千问 | `qwen` | 稳定可靠 |
| Claude 官方 | `claude` | 最新功能 |

### 工作流程

1. 用户在 Claude Code 中请求切换平台
2. Skill 执行 `switch_and_restart.sh` 脚本
3. 脚本自动保存上下文、切换平台
4. 提示用户重启 Claude Code
5. 重启后自动恢复会话上下文

## 开发

### 创建新 Skill

如果你想创建新的 Claude Code Skill：

1. 在 `skills/` 创建新目录
2. 创建 `SKILL.md` 文件（必需）
3. 添加 `scripts/`、`references/` 等辅助文件（可选）
4. 按照 [skill-creator](https://github.com/anthropics/claude-code-skills) 流程开发

### 文档参考

- [Skill 创建指南](https://github.com/anthropics/claude-code-skills)
- [Claude Code 文档](https://docs.anthropic.com/claude-code)

## 许可证

MIT License - 与主项目保持一致

---

**Made with ❤️ for Claude Code users**
