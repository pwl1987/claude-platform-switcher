# 🔐 使用 .env 管理 API Keys

## 📖 概述

为了安全起见，API Keys 不再硬编码在配置文件中，而是通过 `.env` 文件管理。

## ✨ 优点

- ✅ **安全性**：`.env` 文件已加入 `.gitignore`，不会提交到 GitHub
- ✅ **便捷性**：所有 API Keys 集中管理，一处修改全局生效
- ✅ **灵活性**：可以快速切换不同的 API Keys
- ✅ **标准化**：遵循业界标准的 `.env` 管理方式

## 🚀 快速开始

### 1. 创建 .env 文件

在 `~/.claude-platforms/` 目录中创建 `.env` 文件：

```bash
# 复制模板
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env

# 编辑文件
nano ~/.claude-platforms/.env
```

### 2. 填入 API Keys

```bash
# 智谱 GLM
GLM_API_KEY=your-actual-glm-key-here

# MiniMax (注意：使用 AUTH_TOKEN)
MINIMAX_AUTH_TOKEN=your-actual-minimax-key-here

# DeepSeek
DEEPSEEK_API_KEY=your-actual-deepseek-key-here

# 通义千问
QWEN_API_KEY=your-actual-qwen-key-here

# Claude 官方（可选）
ANTHROPIC_API_KEY=your-actual-claude-key-here
```

### 3. 设置文件权限

```bash
chmod 600 ~/.claude-platforms/.env
```

### 4. 正常使用

现在可以正常使用 `switch` 命令切换平台：

```bash
~/.claude-platforms/switch glm
source ~/.claude-platforms/current
claude
```

## 📁 文件说明

### .env.example

模板文件，提交到 GitHub，包含所有必要的环境变量名称。

### .env

实际配置文件，**不提交到 GitHub**，包含你的真实 API Keys。

### .gitignore

已更新，确保 `.env` 文件不会被意外提交：

```gitignore
.env
```

## 🔍 工作原理

```
┌─────────────────┐
│  switch glm      │  执行切换
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  config-glm.sh   │  读取配置
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  .env 文件       │  加载环境变量
│  GLM_API_KEY=... │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  导出环境变量    │  设置到当前 shell
└─────────────────┘
```

## ⚠️ 注意事项

### 1. 文件位置

`.env` 文件必须在 `~/.claude-platforms/` 目录中：

```bash
# 正确位置
~/.claude-platforms/.env

# 错误位置（不会被读取）
./.env
```

### 2. MiniMax 特殊配置

MiniMax 使用 `ANTHROPIC_AUTH_TOKEN` 而不是 `ANTHROPIC_API_KEY`：

```bash
# 正确
MINIMAX_AUTH_TOKEN=your-key

# 错误
MINIMAX_API_KEY=your-key
```

### 3. 环境变量优先级

如果同时存在 `.env` 文件和硬编码的配置，`.env` 优先级更高。

### 4. 安全建议

- 🔒 **文件权限**：`chmod 600 ~/.claude-platforms/.env`
- 🔒 **不要分享**：永远不要把 `.env` 文件发送给任何人
- 🔒 **定期轮换**：建议定期更换 API Keys
- 🔒 **版本控制**：`.env` 已加入 `.gitignore`，不会提交

## 🧪 验证配置

### 测试 .env 加载

```bash
# 测试环境变量是否正确加载
source ~/.claude-platforms/.env
echo $GLM_API_KEY
```

### 测试平台切换

```bash
# 切换到智谱 GLM
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/current

# 验证
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_API_KEY
```

## 🔄 从旧配置迁移

### 如果你之前使用的是旧版配置（硬编码）

1. **备份旧配置**（可选）：

```bash
mkdir -p ~/.claude-platforms/backup
cp ~/.claude-platforms/config-*.sh ~/.claude-platforms/backup/
```

2. **提取 API Keys**：

从旧配置文件中复制你的 API Keys。

3. **创建 .env 文件**：

```bash
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env
nano ~/.claude-platforms/.env
```

4. **粘贴 API Keys**：

把复制的 API Keys 粘贴到 `.env` 文件中对应的位置。

5. **测试新配置**：

```bash
~/.claude-platforms/switch glm
source ~/.claude-platforms/current
```

## 📝 .env 完整示例

```bash
# API Keys 配置
# 注意：不要将此文件提交到 Git

# 智谱 GLM
GLM_API_KEY=1234567890abcdef

# MiniMax (注意：使用 AUTH_TOKEN)
MINIMAX_AUTH_TOKEN=9876543210fedcba

# DeepSeek
DEEPSEEK_API_KEY=abcdefghijklmnopqrstuvwx

# 通义千问
QWEN_API_KEY=zyxwvutsrqponmlkji

# Claude 官方（可选，用于官方 API）
# ANTHROPIC_API_KEY=sk-ant-xxxxx
```

## 🆘 故障排除

### 问题：提示 ".env 文件不存在"

**解决方案**：

```bash
# 创建 .env 文件
cp ~/.claude-platforms/.env.example ~/.claude-platforms/.env

# 填入你的 API Keys
nano ~/.claude-platforms/.env
```

### 问题：提示 "GLM_API_KEY 未设置"

**解决方案**：

1. 检查 `.env` 文件是否存在：
```bash
ls -la ~/.claude-platforms/.env
```

2. 检查变量名是否正确：
```bash
grep GLM_API_KEY ~/.claude-platforms/.env
```

3. 确保没有多余的空格或引号：
```bash
# 正确
GLM_API_KEY=your-key

# 错误
GLM_API_KEY = your-key
GLM_API_KEY="your-key"
```

### 问题：切换后仍然不生效

**解决方案**：

```bash
# 手动加载 .env 文件
source ~/.claude-platforms/.env

# 再次切换平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/current
```

## 🎯 最佳实践

### 1. 环境隔离

为不同项目使用不同的 `.env` 文件：

```bash
~/.claude-platforms/.env          # 默认配置
~/.claude-platforms/.env.work    # 工作配置
~/.claude-platforms/.env.personal # 个人配置
```

### 2. 多机器同步

使用加密工具同步 `.env` 文件：

```bash
# 使用 pass (密码管理器)
pass insert claude-platforms/glm-key

# 或使用 1Password
op item get "Claude Keys" --fields label > ~/.claude-platforms/.env
```

### 3. 定期审计

定期检查 API Keys 使用情况：

- 📊 查看各平台用量统计
- 💰 检查费用是否合理
- 🔄 定期轮换 API Keys
- ❌ 删除不用的 Keys

## 🔗 相关链接

- [dotenv - Python](https://github.com/theskumar/python-dotenv)
- [direnv - Rust](https://direnv.net/)
- [GitHub: Keeping secrets safe](https://docs.github.com/en/get-started/keeping-your-account-and-data-secure/)

---

**💡 提示**: 如果你使用 `direnv` 等工具，可以自动加载 `.env` 文件，无需手动 source。
