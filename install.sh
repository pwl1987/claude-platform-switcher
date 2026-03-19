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
        "$SKILL_DIR/SKILL.md"
    )

    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            print_error "缺失文件: $file"
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
