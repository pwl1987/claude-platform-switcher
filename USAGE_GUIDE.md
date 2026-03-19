# Platform Switcher 技能使用指南

## 快速开始

### 1. 配置 API Keys

```bash
# 编辑 .env 文件
nano ~/.claude-platforms/.env

# 填入你的 API Keys
GLM_API_KEY=your-actual-glm-key
MINIMAX_API_KEY=your-actual-minimax-key
DEEPSEEK_API_KEY=your-actual-deepseek-key
QWEN_API_KEY=your-actual-qwen-key
```

### 2. 在 Claude Code 中使用

现在你可以直接在 Claude Code 中使用自然语言或斜杠命令切换平台！

## 使用方式

### 方式 1：斜杠命令（推荐）

```
/sw:glm
```

```
/sw:minimax
```

```
/sw:deepseek
```

```
/sw:qwen
```

```
/sw:claude
```

### 方式 2：自然语言

直接在 Claude Code 中说：

```
切换到智谱 GLM
```

```
换到 MiniMax
```

```
用 DeepSeek 完成这个任务
```

```
当前用的什么平台？
```

### 方式 3：API Key 配置命令

```
/sw:setkey           # 交互式选择平台配置
/sw:key-glm          # 直接配置智谱 GLM
/sw:key-minimax      # 直接配置 MiniMax
/sw:key-deepseek     # 直接配置 DeepSeek
/sw:key-qwen         # 直接配置通义千问
/sw:key-claude       # 直接配置 Claude
```

## 平台选择建议

| 任务类型 | 推荐平台 | 斜杠命令 | 理由 |
|---------|---------|----------|------|
| 日常编程 | 智谱 GLM | `/sw:glm` | 性价比高 |
| 复杂重构 | MiniMax | `/sw:minimax` | 超长上下文 |
| 快速问答 | DeepSeek | `/sw:deepseek` | 响应快 |
| 生产环境 | 通义千问 | `/sw:qwen` | 稳定可靠 |
| 测试新功能 | Claude 官方 | `/sw:claude` | 原生支持 |

## 完整对话示例

### 示例 1：切换到智谱 GLM

**你**: `/sw:glm`

**Claude**:
```
好的，切换到智谱 GLM 平台。

🔄 执行切换...
✅ 平台已切换到: glm

📋 下一步操作:
   1. 按 Ctrl+D 退出当前 Claude Code 会话
   2. 执行: claude

重启后将使用智谱 GLM 平台。
```

### 示例 2：使用自然语言

**你**: 切换到 MiniMax

**Claude**:
```
切换到 MiniMax 平台。

🔄 执行切换...
✅ 平台已切换到: minimax

📋 下一步操作:
   1. 按 Ctrl+D 退出当前 Claude Code 会话
   2. 执行: claude

重启后将使用 MiniMax 平台（超长上下文，50分钟超时）。
```

### 示例 3：询问当前平台

**你**: 当前用的什么平台？

**Claude**:
```
让我检查一下...

当前平台: DeepSeek

可用平台:
  - /sw:glm      智谱 GLM（三层模型，性价比高）
  - /sw:minimax  MiniMax（超长上下文，50分钟超时）
  - /sw:qwen     通义千问（稳定可靠）
  - /sw:claude   Claude 官方（最新功能）

需要切换到其他平台吗？直接使用斜杠命令即可。
```

### 示例 4：配置 API Key

**你**: `/sw:key-glm`

**Claude**:
```
请提供你的智谱 GLM API Key：

[等待用户输入]

✅ API Key 已保存到 ~/.claude-platforms/.env

现在可以使用 /sw:glm 切换到智谱 GLM 平台。
```

### 示例 5：请求推荐

**你**: 这个重构任务用哪个平台比较好？

**Claude**:
```
根据任务特点，我推荐使用 **MiniMax** 平台。

推荐理由:
- 重构任务需要分析大量代码
- MiniMax 支持超长上下文（50分钟超时）
- 适合复杂的长时间会话

使用 /sw:minimax 切换到 MiniMax 平台。
```

## 斜杠命令速查表

### 平台切换

| 命令 | 功能 |
|------|------|
| `/sw:glm` | 切换到智谱 GLM |
| `/sw:minimax` | 切换到 MiniMax |
| `/sw:deepseek` | 切换到 DeepSeek |
| `/sw:qwen` | 切换到通义千问 |
| `/sw:claude` | 切换到 Claude 官方 |

### API Key 配置

| 命令 | 功能 |
|------|------|
| `/sw:setkey` | 交互式配置 API Key |
| `/sw:key-glm` | 配置智谱 GLM |
| `/sw:key-minimax` | 配置 MiniMax |
| `/sw:key-deepseek` | 配置 DeepSeek |
| `/sw:key-qwen` | 配置通义千问 |
| `/sw:key-claude` | 配置 Claude |

## 技能工作原理

1. **识别意图** - 技能自动识别你的切换意图或平台名称
2. **执行切换** - 调用 `~/.claude-platforms/quick-switch.sh` 脚本
3. **加载配置** - 自动设置环境变量（API 端点、密钥、模型）
4. **保存上下文** - 保存当前会话状态（可选）
5. **提示重启** - 引导你重启 Claude Code 使配置生效

## 故障排除

### 问题：技能没有响应

**解决方案**：
1. 确认技能文件存在：`ls ~/.claude/skills/ | grep sw:`
2. 重启 Claude Code：`Ctrl+D` 退出，然后 `claude` 重新启动
3. 检查技能是否被正确加载

### 问题：斜杠命令不识别

**解决方案**：
```bash
# 检查 skill 目录
ls ~/.claude/skills/

# 应该看到：sw:glm, sw:minimax, sw:deepseek, sw:qwen, sw:claude
# 以及：sw:setkey, sw:key-*

# 如果缺失，重新运行安装
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### 问题：提示 ".env 文件不存在"

**解决方案**：
```bash
# 创建 .env 文件
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env

# 填入 API Keys
nano ~/.claude-platforms/.env
```

### 问题：提示 "API_KEY 未设置"

**解决方案**：
```bash
# 检查 .env 文件内容
cat ~/.claude-platforms/.env

# 确保变量名正确（无多余空格或引号）
# 正确：GLM_API_KEY=your-key
# 错误：GLM_API_KEY = your-key
# 错误：GLM_API_KEY="your-key"
```

### 问题：切换后不生效

**解决方案**：
```bash
# 验证环境变量
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_MODEL

# 手动加载配置
source ~/.claude-platforms/config.sh <平台>
```

## 高级用法

### 自定义别名

在 `~/.bashrc` 中添加：

```bash
# 平台切换快捷命令
alias cc-glm='~/.claude-platforms/quick-switch.sh glm'
alias cc-minimax='~/.claude-platforms/quick-switch.sh minimax'
alias cc-deepseek='~/.claude-platforms/quick-switch.sh deepseek'
alias cc-qwen='~/.claude-platforms/quick-switch.sh qwen'
alias cc-claude='~/.claude-platforms/quick-switch.sh claude'

# 启动 Claude Code（自动使用上次平台）
alias cc='source ~/.claude-platforms/config.sh $(cat ~/.claude-platforms/.current 2>/dev/null || echo "glm") && claude'
```

### 查看切换历史

```bash
# 查看当前平台
cat ~/.claude-platforms/.current

# 查看切换日志
cat ~/.claude-platforms/switch.log
```

## 贡献

如果你有改进建议或发现问题，请：
- 提交 Issue: https://github.com/pwl1987/claude-platform-switcher/issues
- 提交 Pull Request

## 许可证

MIT License
