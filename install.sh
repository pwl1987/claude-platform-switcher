#!/bin/bash
# Claude Code 平台切换器 - 一键安装/升级脚本
# 用法:
#   新安装: curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash
#   升级:   curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade
#   强制:   curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --force

set -e

# ============================================
# 配置
# ============================================
REPO_URL="https://github.com/pwl1987/claude-platform-switcher.git"
INSTALL_DIR="$HOME/.claude-platforms"
SKILL_DIR="$HOME/.claude/skills/platform-switcher"
ENV_BACKUP="/tmp/claude-env-backup-$(date +%s).env"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# ============================================
# 辅助函数
# ============================================

print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║       🔄 Claude Code AI 平台切换器 - 安装程序             ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

show_help() {
    echo ""
    echo -e "${BOLD}用法:${NC}"
    echo "  bash install.sh              # 新安装"
    echo "  bash install.sh --upgrade    # 升级（保留 .env 配置）"
    echo "  bash install.sh --force      # 强制重新安装"
    echo "  bash install.sh --help       # 显示帮助"
    echo ""
    echo -e "${BOLD}从 GitHub 一键安装:${NC}"
    echo "  curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash"
    echo ""
    echo -e "${BOLD}升级:${NC}"
    echo "  curl -fsSL https://raw.githubusercontent.com/pwl1987/claude-platform-switcher/main/install.sh | bash -s -- --upgrade"
    echo ""
}

# ============================================
# 安装检查和备份
# ============================================

# 检测是否已安装
is_installed() {
    [ -f "$INSTALL_DIR/config.sh" ]
}

# 备份 .env 文件
backup_env() {
    if [ -f "$INSTALL_DIR/.env" ]; then
        cp "$INSTALL_DIR/.env" "$ENV_BACKUP"
        print_success ".env 配置已备份"
    fi
}

# 恢复 .env 文件
restore_env() {
    if [ -f "$ENV_BACKUP" ]; then
        cp "$ENV_BACKUP" "$INSTALL_DIR/.env"
        chmod 600 "$INSTALL_DIR/.env"
        rm -f "$ENV_BACKUP"
        print_success ".env 配置已恢复"
    fi
}

# 检查依赖
check_dependencies() {
    print_step "检查依赖..."

    local missing=()

    if ! command -v git &> /dev/null; then
        missing+=("git")
    fi

    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        missing+=("curl 或 wget")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        print_error "缺少依赖: ${missing[*]}"
        echo ""
        echo "请安装缺失的依赖后重试："
        echo "  Ubuntu/Debian: sudo apt install git curl"
        echo "  CentOS/RHEL:   sudo yum install git curl"
        echo "  macOS:         brew install git curl"
        exit 1
    fi

    print_success "依赖检查通过"
}

# ============================================
# 文件安装
# ============================================

# 创建目录结构
create_directories() {
    print_step "创建目录结构..."

    mkdir -p "$INSTALL_DIR/scripts"
    mkdir -p "$SKILL_DIR"

    print_success "目录创建完成"
}

# 下载并安装
install_files() {
    print_step "下载文件..."

    local tmp_dir
    tmp_dir=$(mktemp -d)

    # 克隆仓库
    if ! git clone --depth 1 "$REPO_URL" "$tmp_dir" 2>/dev/null; then
        print_error "克隆仓库失败"
        rm -rf "$tmp_dir"
        exit 1
    fi

    print_success "仓库克隆成功"

    print_step "安装文件..."

    # 复制核心文件
    cp "$tmp_dir/config.sh" "$INSTALL_DIR/"
    cp "$tmp_dir/switch" "$INSTALL_DIR/"
    cp "$tmp_dir/VERSION" "$INSTALL_DIR/"
    cp "$tmp_dir/.env.example" "$INSTALL_DIR/"

    # 复制脚本
    cp "$tmp_dir/scripts/quick-switch.sh" "$INSTALL_DIR/"
    cp "$tmp_dir/scripts/save_context.sh" "$INSTALL_DIR/scripts/" 2>/dev/null || true
    cp "$tmp_dir/scripts/restore_context.sh" "$INSTALL_DIR/scripts/" 2>/dev/null || true
    cp "$tmp_dir/scripts/get_current_platform.sh" "$INSTALL_DIR/scripts/" 2>/dev/null || true
    cp "$tmp_dir/scripts/switch_and_restart.sh" "$INSTALL_DIR/scripts/" 2>/dev/null || true
    cp "$tmp_dir/scripts/configure_api_key.sh" "$INSTALL_DIR/scripts/" 2>/dev/null || true

    # 复制 Skill 文件
    cp "$tmp_dir/SKILL.md" "$SKILL_DIR/"

    # 设置权限
    chmod +x "$INSTALL_DIR/config.sh"
    chmod +x "$INSTALL_DIR/switch"
    chmod +x "$INSTALL_DIR/quick-switch.sh"
    chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null || true

    # 清理临时目录
    rm -rf "$tmp_dir"

    print_success "文件安装完成"
}

# ============================================
# Skill 注册
# ============================================

# 创建各平台的快捷 skill
create_platform_skills() {
    print_step "注册斜杠命令..."

    local platforms=("glm" "minimax" "deepseek" "qwen" "claude")
    local names=("智谱 GLM" "MiniMax" "DeepSeek" "通义千问" "Claude 官方")

    for i in "${!platforms[@]}"; do
        local platform="${platforms[$i]}"
        local name="${names[$i]}"
        local skill_name="sw:${platform}"
        local skill_dir="$HOME/.claude/skills/${skill_name}"

        mkdir -p "$skill_dir"

        cat > "$skill_dir/SKILL.md" << EOF
---
name: ${skill_name}
description: This skill should be used when switching Claude Code to use $name as the AI backend. Triggers on "/${skill_name}" command or phrases like "switch to $name", "use $name", "切换到$name".
---

# Switch to $name

Switch Claude Code to use $name as the AI backend.

## When to Use

- User explicitly requests to use $name
- User types "/${skill_name}" slash command
- User mentions "switch to $name" or "切换到$name"

## Steps

1. Execute the platform switch:
\`\`\`bash
~/.claude-platforms/switch $platform
source ~/.claude-platforms/config.sh $platform
\`\`\`

2. Restart Claude Code to apply changes:
\`\`\`bash
# Press Ctrl+D to exit current session
claude
\`\`\`

## Alternative

For a one-command switch with guidance:
\`\`\`bash
~/.claude-platforms/quick-switch.sh $platform
\`\`\`
EOF
    done

    print_success "斜杠命令已注册: /sw:glm, /sw:minimax, /sw:deepseek, /sw:qwen, /sw:claude"
}

# 创建 API Key 配置 skill
create_api_key_skills() {
    print_step "注册 API Key 配置命令..."

    # 创建 /sw:setkey 斜杠命令
    local setkey_dir="$HOME/.claude/skills/sw:setkey"
    mkdir -p "$setkey_dir"

    cat > "$setkey_dir/SKILL.md" << 'EOF'
---
name: sw:setkey
description: This skill should be used when the user wants to configure API keys for AI platforms. Triggers on "/sw:setkey" command or phrases like "配置 API Key", "设置密钥", "configure api key", "set api key".
---

# Configure API Key

Configure API keys for AI platforms directly in Claude Code.

## When to Use

- User wants to set up or update an API key
- User types "/sw:setkey" slash command
- User mentions "配置 API Key", "设置密钥", "configure key"

## Supported Platforms

| Platform | Variable | Description |
|----------|----------|-------------|
| glm | GLM_API_KEY | 智谱 GLM |
| minimax | MINIMAX_API_KEY | MiniMax |
| deepseek | DEEPSEEK_API_KEY | DeepSeek |
| qwen | QWEN_API_KEY | 通义千问 |
| claude | ANTHROPIC_API_KEY | Claude 官方 |

## Usage

Ask the user which platform they want to configure, then execute:

```bash
~/.claude-platforms/scripts/configure_api_key.sh <platform> <api_key>
```

Examples:

```bash
# Configure GLM
~/.claude-platforms/scripts/configure_api_key.sh glm sk-xxxxxxxx

# Configure MiniMax
~/.claude-platforms/scripts/configure_api_key.sh minimax eyJhbGciOi...

# Configure DeepSeek
~/.claude-platforms/scripts/configure_api_key.sh deepseek sk-xxxxxxxx

# Configure Qwen
~/.claude-platforms/scripts/configure_api_key.sh qwen sk-xxxxxxxx

# Configure Claude
~/.claude-platforms/scripts/configure_api_key.sh claude sk-ant-xxxxxx
```

## Show Current Configuration

```bash
~/.claude-platforms/scripts/configure_api_key.sh show
```

## Workflow

1. Ask user which platform to configure
2. Ask for the API key value
3. Execute the configure script
4. Confirm the configuration was saved
EOF

    # 为每个平台创建独立的配置 skill
    local platforms=("glm" "minimax" "deepseek" "qwen" "claude")
    local names=("智谱 GLM" "MiniMax" "DeepSeek" "通义千问" "Claude 官方")
    local vars=("GLM_API_KEY" "MINIMAX_API_KEY" "DEEPSEEK_API_KEY" "QWEN_API_KEY" "ANTHROPIC_API_KEY")

    for i in "${!platforms[@]}"; do
        local platform="${platforms[$i]}"
        local name="${names[$i]}"
        local var="${vars[$i]}"
        local skill_name="sw:key-${platform}"
        local skill_dir="$HOME/.claude/skills/${skill_name}"

        mkdir -p "$skill_dir"

        cat > "$skill_dir/SKILL.md" << EOF
---
name: ${skill_name}
description: This skill should be used when configuring the API key for $name. Triggers on "/${skill_name}" command or phrases like "配置${name}密钥", "set $name key".
---

# Configure $name API Key

Configure the API key for $name platform.

## Variable

\`${var}\`

## Usage

Ask the user for their API key, then execute:

\`\`\`bash
~/.claude-platforms/scripts/configure_api_key.sh $platform <api_key>
\`\`\`

## Example

User: "配置${name}的 API Key，密钥是 sk-xxxx"

Execute:
\`\`\`bash
~/.claude-platforms/scripts/configure_api_key.sh $platform sk-xxxx
\`\`\`
EOF
    done

    print_success "API Key 配置命令已注册: /sw:setkey, /sw:key-glm, /sw:key-minimax, /sw:key-deepseek, /sw:key-qwen, /sw:key-claude"
}

# ============================================
# 配置和验证
# ============================================

# 配置 .env 文件
setup_env() {
    if [ -f "$INSTALL_DIR/.env" ]; then
        print_success ".env 文件已存在，保留现有配置"
        return
    fi

    print_step "创建 .env 配置文件..."

    if [ -f "$INSTALL_DIR/.env.example" ]; then
        cp "$INSTALL_DIR/.env.example" "$INSTALL_DIR/.env"
        chmod 600 "$INSTALL_DIR/.env"
        print_success ".env 文件已创建"
        print_warning "请编辑 ~/.claude-platforms/.env 填入你的 API Keys"
    fi
}

# 验证安装
verify_installation() {
    print_step "验证安装..."

    local errors=0

    # 检查核心文件
    local required_files=(
        "$INSTALL_DIR/config.sh"
        "$INSTALL_DIR/switch"
        "$INSTALL_DIR/quick-switch.sh"
        "$INSTALL_DIR/VERSION"
        "$INSTALL_DIR/.env.example"
        "$INSTALL_DIR/scripts/configure_api_key.sh"
        "$SKILL_DIR/SKILL.md"
        "$HOME/.claude/skills/sw:setkey/SKILL.md"
    )

    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            print_error "缺失文件: $file"
            ((errors++))
        fi
    done

    # 检查平台 skill 文件
    local platforms=("glm" "minimax" "deepseek" "qwen" "claude")
    for platform in "${platforms[@]}"; do
        if [ ! -f "$HOME/.claude/skills/sw:${platform}/SKILL.md" ]; then
            print_error "缺失 Skill: sw:${platform}"
            ((errors++))
        fi
    done

    if [ $errors -gt 0 ]; then
        print_error "安装验证失败，缺失 $errors 个文件"
        return 1
    fi

    print_success "安装验证通过"
    return 0
}

# 显示安装结果
show_result() {
    local version
    version=$(cat "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")

    echo ""
    echo -e "${GREEN}══════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  ✅ 安装成功！${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  ${BOLD}版本:${NC} $version"
    echo -e "  ${BOLD}安装目录:${NC} $INSTALL_DIR"
    echo -e "  ${BOLD}Skill 目录:${NC} $SKILL_DIR"
    echo ""
    echo -e "${CYAN}📝 已注册的斜杠命令:${NC}"
    echo ""
    echo -e "  ${BOLD}平台切换:${NC}"
    echo -e "    /sw:glm        /sw:minimax    /sw:deepseek"
    echo -e "    /sw:qwen       /sw:claude"
    echo ""
    echo -e "  ${BOLD}API Key 配置:${NC}"
    echo -e "    /sw:setkey         /sw:key-glm    /sw:key-minimax"
    echo -e "    /sw:key-deepseek   /sw:key-qwen   /sw:key-claude"
    echo ""

    if [ ! -f "$INSTALL_DIR/.env" ] || ! grep -q "your-" "$INSTALL_DIR/.env" 2>/dev/null; then
        echo -e "${YELLOW}📋 下一步操作:${NC}"
        echo ""
        echo -e "  ${BLUE}1.${NC} 编辑配置文件，填入 API Keys:"
        echo -e "     ${CYAN}nano ~/.claude-platforms/.env${NC}"
        echo ""
        echo -e "  ${BLUE}2.${NC} 切换到想要的平台:"
        echo -e "     ${CYAN}~/.claude-platforms/switch glm${NC}"
        echo ""
        echo -e "  ${BLUE}3.${NC} 加载配置并启动 Claude Code:"
        echo -e "     ${CYAN}source ~/.claude-platforms/config.sh glm${NC}"
        echo -e "     ${CYAN}claude${NC}"
        echo ""
        echo -e "${YELLOW}💡 提示: 使用 quick-switch.sh 可以一键完成切换${NC}"
    else
        echo -e "${GREEN}📋 快速开始:${NC}"
        echo ""
        echo -e "     ${CYAN}~/.claude-platforms/quick-switch.sh glm${NC}"
        echo ""
    fi

    echo ""
    echo -e "${CYAN}📚 文档: https://github.com/pwl1987/claude-platform-switcher${NC}"
    echo ""
}

# ============================================
# 主逻辑
# ============================================

main() {
    local mode="install"
    local upgrade=false
    local force=false

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --upgrade|-u)
                upgrade=true
                mode="upgrade"
                shift
                ;;
            --force|-f)
                force=true
                mode="force"
                shift
                ;;
            --help|-h)
                print_banner
                show_help
                exit 0
                ;;
            *)
                print_error "未知参数: $1"
                show_help
                exit 1
                ;;
        esac
    done

    print_banner

    # 检查依赖
    check_dependencies

    # 检测安装状态
    if is_installed; then
        if [ "$force" = true ]; then
            print_warning "检测到已有安装，将强制重新安装..."
            backup_env
        elif [ "$upgrade" = true ]; then
            print_step "升级模式：保留配置文件..."
            backup_env
        else
            print_warning "检测到已有安装"
            echo ""
            echo "  - 使用 ${CYAN}--upgrade${NC} 升级（保留配置）"
            echo "  - 使用 ${CYAN}--force${NC} 强制重装"
            echo ""
            exit 0
        fi
    fi

    # 创建目录
    create_directories

    # 安装文件
    install_files

    # 创建各平台的快捷 skill
    create_platform_skills

    # 创建 API Key 配置 skill
    create_api_key_skills

    # 恢复或创建 .env
    if [ "$upgrade" = true ] || [ "$force" = true ]; then
        restore_env
    fi
    setup_env

    # 验证安装
    if ! verify_installation; then
        print_error "安装未完成，请检查错误信息"
        exit 1
    fi

    # 显示结果
    show_result
}

# 执行主函数
main "$@"
