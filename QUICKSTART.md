# 快速开始指南

## 🚀 5 分钟快速上手

### 第一步：安装

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/master/install.sh | bash
```

### 第二步：配置 API Key

编辑配置文件（以智谱 GLM 为例）：

```bash
nano ~/.claude-platforms/config-glm.sh
```

将 `your-glm-api-key-here` 替换为你的实际 API Key。

### 第三步：重新加载配置

```bash
source ~/.bashrc
```

### 第四步：切换平台

```bash
switch glm
```

### 第五步：启动 Claude Code

```bash
source ~/.claude-platforms/current
claude
```

## ✅ 完成验证

启动后，在 Claude Code 中测试对话，如果使用的是智谱 GLM，说明配置成功！

## 📝 常用命令

```bash
# 查看当前状态
switch

# 切换平台
switch <平台名>

# 启动 Claude Code（需先 source 配置）
cc
```

## 🔧 故障排除

### 问题：找不到 switch 命令

**解决**：确保已执行 `source ~/.bashrc` 或重新打开终端。

### 问题：切换后不生效

**解决**：执行 `source ~/.claude-platforms/current` 加载新配置。

### 问题：API 调用失败

**解决**：检查 API Key 是否正确，检查网络连接。

## 📚 更多信息

- 完整文档：[README.md](https://github.com/pwl1987/claude-platform-switcher/blob/master/README.md)
- 提交问题：[GitHub Issues](https://github.com/pwl1987/claude-platform-switcher/issues)
