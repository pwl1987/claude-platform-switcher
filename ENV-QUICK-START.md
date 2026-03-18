# 🔧 使用 .env 管理 API Keys - 快速指南

## 🚀 三步配置

### 步骤 1: 创建 .env 文件

```bash
# 复制模板
cp .env.example ~/.claude-platforms/.env

# 编辑并填入你的真实 API Keys
nano ~/.claude-platforms/.env
```

### 步骤 2: 设置文件权限（安全）

```bash
chmod 600 ~/.claude-platforms/.env
```

### 步骤 3: 正常使用

```bash
# 切换平台
~/.claude-platforms/switch glm

# 加载配置
source ~/.claude-platforms/current

# 启动 Claude Code
claude
```

## ✅ 完成！

现在你的 API Keys 安全地存储在 `~/.claude-platforms/.env` 中，不会提交到 GitHub。

## 📝 .env 文件格式

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
# ANTHROPIC_API_KEY=your-actual-claude-key-here
```

## 🔒 安全提示

- ✅ `.env` 已加入 `.gitignore`，不会提交到 GitHub
- ✅ 文件权限设置为 `600`，只有你可以读取
- ⚠️ 永远不要分享 `.env` 文件
- 🔄 建议定期更换 API Keys

---

详细说明请参考：[ENV-SETUP-GUIDE.md](ENV-SETUP-GUIDE.md)
