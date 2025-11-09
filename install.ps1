# Claude Code 中文开发套件远程安装器 (PowerShell版本)
#
# 该脚本下载并安装 Claude Code 中文开发套件
# 使用方法: irm https://raw.githubusercontent.com/domonic18/ai-claude-init/main/install.ps1 | iex

param(
    [switch]$Force,
    [string]$Branch = "main"
)

# 配置
$REPO_OWNER = "domonic18"
$REPO_NAME = "ai-claude-init"

# 错误处理设置
$ErrorActionPreference = "Stop"

# 颜色输出函数
function Write-ColorOutput {
    param(
        [string]$Message,
        [ConsoleColor]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# 进度指示器
function Show-Spinner {
    param(
        [int]$ProcessId,
        [string]$Activity = "处理中..."
    )
    $spinnerChars = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
    $counter = 0

    while ($true) {
        $process = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
        if (-not $process) { break }

        Write-Progress -Activity $Activity -Status "正在处理..." -PercentComplete ($counter % 100)
        Start-Sleep -Milliseconds 100
        $counter = ($counter + 10) % 100
    }
    Write-Progress -Activity $Activity -Completed
}

# 检查必需命令
function Test-SystemRequirements {
    Write-ColorOutput "📋 正在检查系统要求..." "Yellow"

    $missingDeps = @()

    # 检查 PowerShell 版本
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        $missingDeps += "PowerShell 5.0 或更高版本"
    }

    # 检查网络连接
    try {
        Invoke-WebRequest -Uri "https://api.github.com" -Method Head -TimeoutSec 10 | Out-Null
    }
    catch {
        $missingDeps += "网络连接到 GitHub"
    }

    if ($missingDeps.Count -gt 0) {
        Write-ColorOutput "❌ 缺少必需要求:" "Red"
        foreach ($dep in $missingDeps) {
            Write-ColorOutput "  • $dep" "Red"
        }
        Write-ColorOutput "请在运行安装器前解决这些问题。" "Red"
        exit 1
    }

    Write-ColorOutput "✅ 系统要求已满足" "Green"
}

# 创建临时目录
$tempDir = Join-Path $env:TEMP "claude-init-$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

# 清理函数
function Cleanup {
    if (Test-Path $tempDir) {
        Write-ColorOutput "🧹 正在清理临时文件..." "Yellow"
        Remove-Item -Path $tempDir -Recurse -Force
        Write-ColorOutput "✅ 清理完成" "Green"
    }
}

# 设置清理钩子
$cleanupJob = Start-Job -ScriptBlock {
    param($tempDir)
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
} -ArgumentList $tempDir

# 主要安装流程
try {
    # 显示横幅
    Clear-Host
    Write-ColorOutput "╔═══════════════════════════════════════════════╗" "Blue"
    Write-ColorOutput "║                                               ║" "Blue"
    Write-ColorOutput "║    🚀 Claude Code 中文开发套件安装器         ║" "Blue"
    Write-ColorOutput "║              (PowerShell版本)                 ║" "Blue"
    Write-ColorOutput "║                                               ║" "Blue"
    Write-ColorOutput "╚═══════════════════════════════════════════════╝" "Blue"
    Write-Host ""

    # 检查系统要求
    Test-SystemRequirements
    Write-Host ""

    # 下载框架
    Write-ColorOutput "📥 正在下载 Claude Code 中文开发套件..." "Cyan"
    $downloadUrl = "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/tarball/${Branch}"
    Write-ColorOutput "下载地址: $downloadUrl" "Yellow"

    $zipPath = Join-Path $tempDir "framework.zip"

    # 使用 Invoke-WebRequest 下载
    try {
        Write-Progress -Activity "下载框架" -Status "正在从 GitHub 下载..." -PercentComplete 0
        Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -Headers @{
            "Accept" = "application/vnd.github.v3+json"
            "User-Agent" = "Claude-Init-Installer"
        }
        Write-Progress -Activity "下载框架" -Completed

        if (Test-Path $zipPath) {
            $size = [math]::Round((Get-Item $zipPath).Length / 1MB, 2)
            Write-ColorOutput "✅ 下载完成 (${size}MB)" "Green"
        } else {
            throw "下载文件未找到"
        }
    }
    catch {
        Write-ColorOutput "❌ 下载框架失败" "Red"
        Write-ColorOutput "错误详情: $($_.Exception.Message)" "Red"
        Write-Host ""
        Write-ColorOutput "可能的解决方案：" "Yellow"
        Write-Host "  1. 检查你的网络连接"
        Write-Host "  2. 验证仓库是否存在: https://github.com/${REPO_OWNER}/${REPO_NAME}"
        Write-Host "  3. 确保 Claude Code 已安装: https://github.com/anthropics/claude-code"
        Write-Host "  4. 尝试手动安装 (git clone)"
        exit 1
    }

    # 解压文件
    Write-Host ""
    Write-ColorOutput "📦 正在解压框架文件..." "Cyan"

    try {
        Write-Progress -Activity "解压框架" -Status "正在解压文件..." -PercentComplete 0
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        Write-Progress -Activity "解压框架" -Completed

        # 查找解压目录
        $extractDir = Get-ChildItem -Path $tempDir -Directory | Where-Object { $_.Name -like "${REPO_OWNER}-${REPO_NAME}-*" } | Select-Object -First 1

        if (-not $extractDir) {
            throw "找不到解压的框架目录"
        }

        Write-ColorOutput "✅ 解压完成" "Green"
        Write-Host ""

        # 验证 setup.ps1 存在
        $setupScript = Join-Path $extractDir.FullName "setup.ps1"
        if (-not (Test-Path $setupScript)) {
            Write-ColorOutput "❌ 在解压文件中未找到 setup.ps1" "Red"
            exit 1
        }

        # 保存原始目录
        $originalPwd = Get-Location

        # 切换到解压目录并运行设置
        Set-Location $extractDir.FullName

        Write-ColorOutput "🔧 开始框架设置..." "Cyan"
        Write-ColorOutput "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "Cyan"
        Write-Host ""

        # 运行设置脚本
        $env:INSTALLER_ORIGINAL_PWD = $originalPwd.Path
        & $setupScript @args

        if ($LASTEXITCODE -ne 0) {
            Write-Host ""
            Write-ColorOutput "❌ 设置失败" "Red"
            Write-ColorOutput "你可以尝试手动安装：" "Yellow"
            Write-Host "  git clone https://github.com/${REPO_OWNER}/${REPO_NAME}.git"
            Write-Host "  cd ${REPO_NAME}"
            Write-Host "  .\setup.ps1"
            exit 1
        }

        # 成功完成
        Write-Host ""
        Write-ColorOutput "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "Green"
        Write-ColorOutput "🎉 Claude Code 中文开发套件安装完成！" "Green"
        Write-ColorOutput "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "Green"
    }
    catch {
        Write-ColorOutput "❌ 解压或设置过程中出错: $($_.Exception.Message)" "Red"
        exit 1
    }
}
catch {
    Write-ColorOutput "❌ 安装过程中发生错误: $($_.Exception.Message)" "Red"
    exit 1
}
finally {
    # 返回原始目录
    if ($originalPwd) {
        Set-Location $originalPwd
    }

    # 清理临时文件
    Cleanup
}