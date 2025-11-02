#!/bin/bash

# install-launchd-service.sh
# 动态安装Launchd定时任务服务

set -euo pipefail

# 配置变量
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
LAUNCH_AGENTS_DIR="${HOME}/Library/LaunchAgents"
PLIST_TEMPLATE="${SCRIPT_DIR}/com.user.claude-git-report.template.plist"
PLIST_FINAL="${LAUNCH_AGENTS_DIR}/com.user.claude-git-report.plist"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "[${timestamp}] $1"
}

log_success() {
    log "${GREEN}✅ $1${NC}"
}

log_warning() {
    log "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    log "${RED}❌ $1${NC}"
}

# 检查前置条件
check_prerequisites() {
    log "检查前置条件..."

    # 检查项目根目录是否存在
    if [ ! -d "${PROJECT_ROOT}" ]; then
        log_error "项目根目录不存在: ${PROJECT_ROOT}"
        exit 1
    fi

    # 检查模板文件是否存在
    if [ ! -f "${PLIST_TEMPLATE}" ]; then
        log_error "plist模板文件不存在: ${PLIST_TEMPLATE}"
        exit 1
    fi

    # 检查LaunchAgents目录是否存在
    if [ ! -d "${LAUNCH_AGENTS_DIR}" ]; then
        log_warning "LaunchAgents目录不存在，正在创建..."
        mkdir -p "${LAUNCH_AGENTS_DIR}"
    fi

    log_success "前置条件检查通过"
}

# 生成最终的plist文件
generate_plist() {
    log "生成动态plist文件..."

    # 使用sed替换模板中的占位符
    sed \
        -e "s|{{PROJECT_ROOT}}|${PROJECT_ROOT}|g" \
        -e "s|{{HOME}}|${HOME}|g" \
        "${PLIST_TEMPLATE}" > "${PLIST_FINAL}"

    log_success "plist文件已生成: ${PLIST_FINAL}"
}

# 安装Launchd服务
install_service() {
    log "安装Launchd服务..."

    # 卸载可能存在的旧服务
    if launchctl list | grep -q "com.user.claude-git-report"; then
        log_warning "发现已存在的服务，正在卸载..."
        launchctl unload "${PLIST_FINAL}" 2>/dev/null || true
    fi

    # 加载新服务
    launchctl load "${PLIST_FINAL}"

    if [ $? -eq 0 ]; then
        log_success "Launchd服务安装成功"
    else
        log_error "Launchd服务安装失败"
        exit 1
    fi
}

# 显示安装信息
show_installation_info() {
    echo ""
    log_success "🎉 Git报告定时任务安装完成！"
    echo ""
    echo "📋 安装信息："
    echo "   项目路径: ${PROJECT_ROOT}"
    echo "   plist文件: ${PLIST_FINAL}"
    echo "   执行时间: 每周一上午8:00"
    echo "   执行命令: claude \"生成上周的周报并发送到企微机器人\""
    echo ""
    echo "🔧 管理命令："
    echo "   查看状态: launchctl list | grep claude-git-report"
    echo "   手动启动: launchctl start com.user.claude-git-report"
    echo "   停止服务: launchctl unload ${PLIST_FINAL}"
    echo "   重新加载: launchctl unload ${PLIST_FINAL} && launchctl load ${PLIST_FINAL}"
    echo ""
    echo "📝 注意事项："
    echo "   - 确保已设置 WECHAT_WEBHOOK_URL 环境变量"
    echo "   - 服务将在每周一上午8:00自动执行"
    echo "   - 日志文件: ~/.claude/logs/daily-report-launchd.log"
    echo ""
}

# 主函数
main() {
    log "=== Git报告定时任务安装程序 ==="

    check_prerequisites
    generate_plist
    install_service
    show_installation_info

    log "=== 安装完成 ==="
}

# 脚本入口
main "$@"