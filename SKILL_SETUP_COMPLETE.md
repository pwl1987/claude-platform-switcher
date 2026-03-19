# ✅ Platform Switcher 技能设置完成！

## 已完成的工作

### 1. 技能文件创建 ✅
- **位置**: `/data/Code/skill/claude-platform-switcher/.claude/skills/platform-switcher/SKILL.md`
- **功能**: Claude Code 技能定义，支持自然语言和斜杠命令

### 2. 核心脚本配置 ✅
- **config.sh**: 统一配置加载脚本 (`~/.claude-platforms/config.sh`)
- **switch**: 平台切换脚本 (已存在)
- **quick-switch.sh**: 一键切换脚本 (已存在)

### 3. 环境配置 ✅
- **.env.example**: API Keys 配置模板
- **.env**: 环境变量文件（已创建，需填入真实 API Keys）
- **权限设置**: `.env` 文件权限为 600（安全）

### 4. 文档完善 ✅
- **USAGE_GUIDE.md**: 详细使用指南
- **README.md**: 项目说明（已更新）
- **SKILL.md**: 技能文档（已更新）

## 如何使用

### 在 Claude Code 中直接使用

现在你可以在 Claude Code 中使用以下方式切换平台：

#### 方式 1：斜杠命令（推荐）
```
/sw:glm        - 切换到智谱 GLM
/sw:minimax    - 切换到 MiniMax
/sw:deepseek   - 切换到 DeepSeek
/sw:qwen       - 切换到通义千问
/sw:claude     - 切换到 Claude 官方
```

#### 方式 2：自然语言
```
切换到智谱 GLM
换到 MiniMax
用 DeepSeek 完成这个任务
当前用的什么平台？
```

#### 方式 3：API Key 配置
```
/sw:setkey         - 交互式配置 API Key
/sw:key-glm        - 配置智谱 GLM
/sw:key-minimax    - 配置 MiniMax
/sw:key-deepseek   - 配置 DeepSeek
/sw:key-qwen       - 配置通义千问
/sw:key-claude     - 配置 Claude
```

## 下一步操作

### 1. 配置 API Keys

编辑 `~/.claude-platforms/.env` 文件，填入你的真实 API Keys：

```bash
nano ~/.claude-platforms/.env
```

填入以下内容：
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

### 2. 重启 Claude Code

为了让技能生效，需要重启 Claude Code：

```bash
# 退出当前会话
按 Ctrl+D

# 重新启动
claude
```

### 3. 测试技能

重启后，在 Claude Code 中输入：

```
/sw:glm
```

或者：

```
切换到智谱 GLM
```

Claude 应该会自动识别并执行切换！

## 技能工作流程

```
用户输入 → 技能识别 → 执行脚本 → 加载配置 → 提示重启
   ↓           ↓          ↓          ↓          ↓
"切换到GLM"  识别意图   quick-switch  设置环境变量  显示指导
/sw:glm     提取平台    执行切换     ANTHROPIC_*  "Ctrl+D"
```

## 平台选择建议

| 任务类型 | 推荐平台 | 斜杠命令 | 理由 |
|---------|---------|----------|------|
| 日常编程 | 智谱 GLM | `/sw:glm` | 性价比高，三层模型 |
| 复杂重构 | MiniMax | `/sw:minimax` | 超长上下文，50分钟超时 |
| 快速问答 | DeepSeek | `/sw:deepseek` | 响应快 |
| 生产环境 | 通义千问 | `/sw:qwen` | 稳定可靠 |
| 测试新功能 | Claude 官方 | `/sw:claude` | 原生支持 |

## 故障排除

### 技能没有响应？

1. **检查技能文件是否存在**：
   ```bash
   ls ~/.claude/skills/ | grep sw:
   ```

2. **重启 Claude Code**：
   ```bash
   # 退出并重启
   Ctrl+D
   claude
   ```

3. **检查 .env 文件**：
   ```bash
   # 确保 .env 文件存在并已填入 API Keys
   cat ~/.claude-platforms/.env
   ```

### 斜杠命令不识别？

```bash
# 检查 skill 目录
ls ~/.claude/skills/

# 应该看到：sw:glm, sw:minimax, sw:deepseek, sw:qwen, sw:claude
# 以及：sw:setkey, sw:key-*

# 如果缺失，重新运行安装
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### API Keys 获取地址

- **智谱 GLM**: https://open.bigmodel.cn/
- **MiniMax**: https://api.minimaxi.com/
- **DeepSeek**: https://platform.deepseek.com/
- **通义千问**: https://dashscope.aliyuncs.com/
- **Claude 官方**: https://console.anthropic.com/

## 项目文件结构

```
claude-platform-switcher/
├── .claude/
│   └── skills/
│       └── platform-switcher/
│           └── SKILL.md              # ✨ 技能定义文件
├── scripts/
│   ├── save_context.sh
│   ├── restore_context.sh
│   └── get_current_platform.sh
├── config.sh                          # 配置加载脚本
├── switch                            # 平台切换脚本
├── .env.example                      # API Keys 模板
├── USAGE_GUIDE.md                    # 使用指南
├── README.md                         # 项目说明
└── SKILL.md                          # 技能文档

~/.claude/skills/                     # 斜杠命令目录
├── platform-switcher/                # 主技能
├── sw:glm/                           # GLM 切换命令
├── sw:minimax/                       # MiniMax 切换命令
├── sw:deepseek/                      # DeepSeek 切换命令
├── sw:qwen/                          # 通义千问切换命令
├── sw:claude/                        # Claude 切换命令
├── sw:setkey/                        # API Key 配置命令
├── sw:key-glm/                       # GLM Key 配置
├── sw:key-minimax/                   # MiniMax Key 配置
├── sw:key-deepseek/                  # DeepSeek Key 配置
├── sw:key-qwen/                      # 通义千问 Key 配置
└── sw:key-claude/                    # Claude Key 配置
```

## 成功标志

当你看到以下输出时，说明设置成功：

```
✅ 平台已切换到: glm

📋 下一步操作:
   1. 按 Ctrl+D 退出当前 Claude Code 会话
   2. 执行: claude

重启后将使用 glm 平台
```

## 支持与反馈

- **GitHub**: https://github.com/pwl1987/claude-platform-switcher
- **Issues**: https://github.com/pwl1987/claude-platform-switcher/issues
- **文档**: 查看 `USAGE_GUIDE.md` 了解更多

---

**🎉 恭喜！你现在可以在 Claude Code 中用斜杠命令切换 AI 平台了！**
