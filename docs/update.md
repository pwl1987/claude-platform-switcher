# Claude Code 平台切换器 — 升级指南

## For Humans

复制这句话给你的 AI Agent：

```
帮我升级 Claude Code 平台切换器：https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/docs/update.md
```

---

## For AI Agents

### Goal

升级 Claude Code 平台切换器到最新版本，同时**保留用户的 API Keys 配置**。

### ⚠️ 关键原则

- **必须保留** `~/.claude-platforms/.env` 文件（用户的 API Keys）
- **必须保留** `~/.claude-platforms/.current` 文件（当前平台选择）
- 更新脚本和 Skill 文件

### Step 1: 备份配置

```bash
# 备份 .env 文件
cp ~/.claude-platforms/.env /tmp/claude-env-backup.env 2>/dev/null || echo "No .env to backup"

# 记录当前平台
cat ~/.claude-platforms/.current 2>/dev/null > /tmp/claude-current-backup
```

### Step 2: 运行升级脚本

```bash
curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
```

### Step 3: 验证配置保留

```bash
# 检查 .env 是否保留
cat ~/.claude-platforms/.env | head -5

# 检查当前平台
cat ~/.claude-platforms/.current
```

### Step 4: 验证升级

```bash
# 查看新版本
cat ~/.claude-platforms/VERSION

# 测试切换命令
~/.claude-platforms/switch
```

### Step 5: 汇报结果

告诉用户：

> "升级完成！版本：X.X.X。你的 API Keys 和当前平台配置已保留。"

---

## 手动升级（可选）

如果自动升级失败，可以手动执行：

```bash
# 1. 备份配置
cp ~/.claude-platforms/.env ~/.claude-platforms/.env.backup
cp ~/.claude-platforms/.current ~/.claude-platforms/.current.backup 2>/dev/null

# 2. 下载最新版本
cd /tmp
git clone https://github.com/pwl1987/claude-platform-switcher.git
cd claude-platform-switcher

# 3. 更新脚本文件（保留 .env 和 .current）
cp config.sh switch ~/.claude-platforms/
cp -r scripts ~/.claude-platforms/
cp VERSION ~/.claude-platforms/

# 4. 验证
~/.claude-platforms/switch
```

---

## 升级后检查清单

- [ ] `~/.claude-platforms/.env` 文件存在且包含你的 API Keys
- [ ] `~/.claude-platforms/.current` 显示正确的平台
- [ ] `~/.claude-platforms/switch` 命令正常工作
- [ ] `~/.claude-platforms/VERSION` 显示新版本号

---

**GitHub**: https://github.com/pwl1987/claude-platform-switcher
