# Claude Code 平台切换器

极简方案，通过切换配置文件来使用不同的 AI 平台（MiniMax、智谱 GLM、DeepSeek、通义千问等）。

## 原理

通过环境变量 `ANTHROPIC_BASE_URL` 和 `ANTHROPIC_API_KEY` 来指定 Claude Code 使用的 API 端点。

## 文件结构

```
~/.claude-platforms/
├── switch              # 切换脚本
├── config-minimax.sh   # MiniMax 配置
├── config-glm.sh       # 智谱 GLM 配置
├── config-qwen.sh      # 通义千问配置
├── config-deepseek.sh  # DeepSeek 配置
└── current             # 当前平台软链接
```

## 使用方法

### 1. 配置 API Keys

编辑配置文件，填入你的 API Keys：

```bash
# 编辑 MiniMax 配置
nano ~/.claude-platforms/config-minimax.sh

# 编辑智谱配置
nano ~/.claude-platforms/config-glm.sh

# 编辑 DeepSeek 配置
nano ~/.claude-platforms/config-deepseek.sh
```

### 2. 添加到 PATH

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
echo 'export PATH="$HOME/.claude-platforms:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 3. 查看可用平台

```bash
switch
```

### 4. 切换平台

```bash
# 切换到智谱 GLM
switch glm

# 切换到 MiniMax
switch minimax

# 切换到 DeepSeek
switch deepseek
```

### 5. 加载配置并启动 Claude Code

```bash
# 方法1: 手动加载
source ~/.claude-platforms/current
claude

# 方法2: 添加快捷命令到 ~/.bashrc
alias cc='source ~/.claude-platforms/current && claude'
```

## 快捷启动（推荐）

添加到 `~/.bashrc`：

```bash
# Claude Code 平台切换器
export PATH="$HOME/.claude-platforms:$PATH"
alias switch="~/.claude-platforms/switch"

# 自动加载当前平台配置
if [ -f "$HOME/.claude-platforms/current" ]; then
    source "$HOME/.claude-platforms/current"
fi

# 快捷启动命令
alias cc='claude'
```

这样每次打开新终端都会自动加载当前平台配置，直接使用 `cc` 启动即可。

## 支持的平台

- **minimax**: MiniMax (abab6.5s-chat)
- **glm**: 智谱 GLM (glm-4-plus)
- **deepseek**: DeepSeek (deepseek-chat)
- **qwen**: 通义千问 (qwen-plus)

## 添加新平台

创建新的配置文件：

```bash
cat > ~/.claude-platforms/config-新平台名.sh << 'EOF'
#!/bin/bash
export ANTHROPIC_BASE_URL="https://api.example.com/v1"
export ANTHROPIC_API_KEY="your-api-key-here"
export OPENAI_MODEL="model-name"
EOF

chmod +x ~/.claude-platforms/config-新平台名.sh
```

## 验证测试

```bash
# 1. 切换到智谱
switch glm

# 2. 加载配置
source ~/.claude-platforms/current

# 3. 验证环境变量
echo $ANTHROPIC_BASE_URL
echo $ANTHROPIC_API_KEY

# 4. 启动 Claude Code
claude
```
