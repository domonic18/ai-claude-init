#!/bin/bash

# git-report-automation.sh
# 极简自动化Git报告调度脚本 - 支持日报和周报，默认执行周报

set -euo pipefail

# 配置变量
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
LOG_FILE="${HOME}/.claude/logs/daily-report-automation.log"

# 创建日志目录
mkdir -p "$(dirname "${LOG_FILE}")"

# 日志函数
log() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] $1" | tee -a "${LOG_FILE}"
}

# 主函数
main() {
    log "=== 开始自动化Git报告调度 ==="

    # 切换到项目目录
    cd "${PROJECT_ROOT}"

    # 检查Git仓库
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log "错误：当前目录不是Git仓库"
        exit 1
    fi

    # 调用Claude Code生成周报并发送到企微机器人
    # 默认执行周报模式（每周一执行）
    log "执行命令: claude \"生成上周的周报并发送到企微机器人\""

    # 实际调用Claude Code命令
    claude "生成上周的周报并发送到企微机器人"

    log "=== 自动化Git报告调度完成 ==="
}

# 脚本入口
main "$@"