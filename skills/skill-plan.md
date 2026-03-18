# Platform Switcher Skill - 创建计划

## Step 1: 具体使用场景

### 典型用户请求：
- "切换到智谱 GLM"
- "使用 MiniMax 完成这个任务"
- "我想用 DeepSeek"
- "切换回 Claude 官方"
- "当前使用什么平台？"

### 使用流程：
1. 用户请求切换平台
2. Skill 执行切换脚本
3. 保存当前会话上下文
4. 重启 Claude Code
5. 自动恢复会话上下文

## Step 2: 可重用资源规划

### Scripts（必需）
1. **`scripts/switch_and_restart.sh`**
   - 功能：切换平台并重启 Claude Code
   - 参数：目标平台名称（glm, minimax, deepseek, qwen, claude）
   - 作用：核心执行脚本

2. **`scripts/save_context.sh`**
   - 功能：保存当前会话上下文
   - 输出：`~/.claude-platforms/session-context.json`
   - 包含：当前对话摘要、待办事项、工作目录

3. **`scripts/restore_context.sh`**
   - 功能：恢复会话上下文
   - 输入：`~/.claude-platforms/session-context.json`
   - 输出：打印恢复信息给 Claude

4. **`scripts/get_current_platform.sh`**
   - 功能：获取当前平台
   - 输出：平台名称

### References（可选）
1. **`references/platforms.md`**
   - 各平台配置详情
   - API 端点、模型映射、使用场景

2. **`references/usage.md`**
   - 使用指南
   - 常见问题、故障排除

### Assets（不需要）
- 本工具是配置管理，不产生输出文件

## Step 3: 目录结构

```
platform-switcher/
├── SKILL.md                    # 主技能文件
├── scripts/                    # 执行脚本
│   ├── switch_and_restart.sh   # 切换并重启
│   ├── save_context.sh         # 保存上下文
│   ├── restore_context.sh      # 恢复上下文
│   └── get_current_platform.sh # 获取当前平台
└── references/                 # 参考文档
    ├── platforms.md            # 平台详情
    └── usage.md                # 使用指南
```

## Step 4: SKILL.md 内容要点

### Metadata
- name: platform-switcher
- description: 用于在 Claude Code 中快速切换 AI 平台（MiniMax、智谱 GLM、DeepSeek、通义千问、Claude 官方），自动保存会话上下文并重启，支持无缝恢复工作进度

### 触发条件
- 用户明确提到切换平台："切换到 X 平台"、"使用 X"
- 提及平台名称：MiniMax、智谱 GLM、DeepSeek、通义千问
- 询问当前平台："当前用的是什么平台"

### 使用流程
1. 确认目标平台
2. 执行 switch_and_restart.sh
3. 脚本自动保存上下文、切换、重启
4. 重启后自动恢复上下文
5. 确认切换成功

## Step 5: 实现细节

### switch_and_restart.sh 逻辑
```bash
#!/bin/bash
TARGET_PLATFORM=$1

# 1. 保存上下文
~/.claude/skills/platform-switcher/scripts/save_context.sh

# 2. 切换平台
~/.claude-platforms/switch $TARGET_PLATFORM

# 3. 重启 Claude Code
killall claude && sleep 1 && claude

# 4. 恢复上下文（在新会话中）
~/.claude/skills/platform-switcher/scripts/restore_context.sh
```

### 上下文保存格式
```json
{
  "timestamp": "2026-03-18T10:30:00",
  "previous_platform": "deepseek",
  "current_directory": "/data/Code/skill/claude-platform-switcher",
  "conversation_summary": "正在创建 platform-switcher skill",
  "active_tasks": [
    "创建 Claude Code platform-switcher skill"
  ],
  "work_state": "in_progress"
}
```
