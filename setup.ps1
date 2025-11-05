# Claude Code Chinese Development Kit Setup Script (PowerShell Version)
# Includes interactive MCP server configuration

param(
    [switch]$Force
)

# Error handling settings
$ErrorActionPreference = "Stop"

# Color output functions
function Write-ColorOutput {
    param(
        [string]$Message,
        [ConsoleColor]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Configuration variables
$TARGET_DIR = if ($env:INSTALLER_ORIGINAL_PWD) { $env:INSTALLER_ORIGINAL_PWD } else { Get-Location }
# Install all MCP servers by default
$INSTALL_CONTEXT7 = $true
$INSTALL_GEMINI = $true
$INSTALL_NOTIFICATIONS = $true

# Safe read function (for non-interactive mode)
function Read-YesNo {
    param(
        [string]$Prompt,
        [bool]$Default = $false
    )

    $response = Read-Host "$Prompt [Y/N] (default: $(if($Default) {'Y'} else {'N'}))"

    if ([string]::IsNullOrWhiteSpace($response)) {
        return $Default
    }

    return $response -match '^[Yy]|[Yy][Ee][Ss]$'
}

function Write-Header {
    Write-Host ""
    Write-ColorOutput "===========================================" "Blue"
    Write-ColorOutput "   Claude Code Chinese Development Kit Setup" "Blue"
    Write-ColorOutput "===========================================" "Blue"
    Write-Host ""
}

function Write-Success {
    Write-ColorOutput "[OK] $args" "Green"
}

function Write-Info {
    Write-ColorOutput "[INFO] $args" "Cyan"
}

function Write-Warning {
    Write-ColorOutput "[WARN] $args" "Yellow"
}

function Write-Error {
    Write-ColorOutput "[ERROR] $args" "Red"
}

# Check dependencies
function Test-Dependencies {
    Write-Info "Checking system dependencies..."

    # Check Git
    try {
        $gitVersion = git --version
        Write-Success "Git: $gitVersion"
    }
    catch {
        Write-Error "Git not installed or not in PATH"
        Write-Host "Please install Git from https://git-scm.com/downloads"
        exit 1
    }

    # Check Node.js (for MCP servers)
    try {
        $nodeVersion = node --version
        Write-Success "Node.js: $nodeVersion"
    }
    catch {
        Write-Warning "Node.js not installed, some MCP servers may not work"
        Write-Host "Recommended to install Node.js from https://nodejs.org/"
    }

    # Check Claude Code
    try {
        $claudeVersion = claude --version
        Write-Success "Claude Code: $claudeVersion"
    }
    catch {
        Write-Error "Claude Code not installed or not in PATH"
        Write-Host "Please install Claude Code from https://claude.com/claude-code"
        exit 1
    }
}

# Create directory structure
function Initialize-Directories {
    Write-Info "Initializing directory structure..."

    $directories = @(
        ".claude",
        ".claude/agents",
        ".claude/commands",
        ".claude/hooks",
        ".claude/hooks/config",
        ".claude/hooks/sounds",
        ".claude/hooks/setup",
        ".claude/skills",
        ".claude/skills/news",
        ".claude/skills/git-report"
    )

    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Success "Created directory: $dir"
        }
    }
}

# Copy template files
function Copy-Templates {
    Write-Info "Copying template files..."

    $templateFiles = Get-ChildItem -Path "templates" -Recurse -File

    foreach ($file in $templateFiles) {
        $relativePath = $file.FullName.Replace((Get-Location).Path + "\templates\", "")
        $targetPath = ".claude\$relativePath"

        # Ensure target directory exists
        $targetDir = Split-Path $targetPath -Parent
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        # Copy file if it doesn't exist or force overwrite
        if (-not (Test-Path $targetPath) -or $Force) {
            Copy-Item $file.FullName $targetPath -Force
            Write-Success "Copied: $relativePath"
        }
        else {
            Write-Info "Skipped (exists): $relativePath"
        }
    }
}

# Configure MCP servers
function Configure-MCP {
    Write-Info "Configuring MCP servers..."

    $settingsPath = ".claude\settings.local.json"
    $templatePath = "templates\.claude\settings.local.json"

    # Create settings file from template if it doesn't exist
    if (-not (Test-Path $settingsPath)) {
        if (Test-Path $templatePath) {
            Copy-Item $templatePath $settingsPath
            Write-Success "Created MCP configuration file"
        }
        else {
            Write-Warning "MCP configuration template not found"
        }
    }
    else {
        Write-Info "MCP configuration file already exists"
    }

    # Ask user to configure MCP servers
    if ($INSTALL_CONTEXT7 -and (Read-YesNo "Configure Context7 MCP server?" $true)) {
        $context7ApiKey = Read-Host "Enter Context7 API Key (leave empty to skip)"
        if (-not [string]::IsNullOrWhiteSpace($context7ApiKey)) {
            Update-MCPConfig -ServerName "context7" -ApiKey $context7ApiKey
            Write-Success "Context7 configuration completed"
        }
    }

    if ($INSTALL_GEMINI -and (Read-YesNo "Configure Gemini MCP server?" $true)) {
        $geminiApiKey = Read-Host "Enter Gemini API Key (leave empty to skip)"
        if (-not [string]::IsNullOrWhiteSpace($geminiApiKey)) {
            Update-MCPConfig -ServerName "gemini" -ApiKey $geminiApiKey
            Write-Success "Gemini configuration completed"
        }
    }
}

# Update MCP configuration
function Update-MCPConfig {
    param(
        [string]$ServerName,
        [string]$ApiKey
    )

    $settingsPath = ".claude\settings.local.json"

    if (Test-Path $settingsPath) {
        $settings = Get-Content $settingsPath | ConvertFrom-Json

        if (-not $settings.mcpServers) {
            $settings | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue @{} -Force
        }

        switch ($ServerName) {
            "context7" {
                $settings.mcpServers.context7 = @{
                    command = "npx"
                    args = @("-y", "@upstash/context7-mcp", "--api-key", $ApiKey)
                }
            }
            "gemini" {
                $settings.mcpServers.gemini = @{
                    command = "npx"
                    args = @("-y", "@modelcontextprotocol/server-gemini", "--apiKey", $ApiKey)
                }
            }
        }

        $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    }
}

# Create base documentation
function Create-BaseDocs {
    Write-Info "Creating base documentation..."

    # Create CLAUDE.md if it doesn't exist
    if (-not (Test-Path "CLAUDE.md")) {
        $claudeContent = @"
# Project Context Document

## Project Overview
This is a project using Claude Code Chinese Development Kit.

## Development Standards
- Use Chinese comments and documentation
- Follow project code standards
- Use standard Git commit message format

## AI Assistant Instructions
- Prefer Chinese communication
- Follow project architecture and code standards
- Provide detailed code comments
"@
        $claudeContent | Set-Content "CLAUDE.md" -Encoding UTF8
        Write-Success "Created CLAUDE.md"
    }
    else {
        Write-Info "CLAUDE.md already exists"
    }
}

# Verify installation
function Test-Installation {
    Write-Info "Verifying installation..."

    $requiredFiles = @(
        ".claude/commands/code-review.md",
        ".claude/commands/full-context.md",
        ".claude/commands/gitcommit.md",
        ".claude/commands/update-docs.md",
        ".claude/hooks/subagent-context-injector.sh",
        ".claude/agents/README.md"
    )

    $missingFiles = @()
    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            $missingFiles += $file
        }
    }

    if ($missingFiles.Count -eq 0) {
        Write-Success "All required files installed"
    }
    else {
        Write-Warning "Missing files: $($missingFiles -join ', ')"
    }

    # Test Claude Code commands
    try {
        $commands = claude --help
        Write-Success "Claude Code commands available"
    }
    catch {
        Write-Error "Claude Code command test failed"
    }
}

# Main installation function
function Install-ClaudeInit {
    Write-Header

    Write-Info "Starting Claude Code Chinese Development Kit installation..."
    Write-Host "Target directory: $TARGET_DIR"
    Write-Host ""

    # Execute installation steps
    Test-Dependencies
    Initialize-Directories
    Copy-Templates
    Configure-MCP
    Create-BaseDocs
    Test-Installation

    Write-Host ""
    Write-ColorOutput "*** Claude Code Chinese Development Kit setup completed! ***" "Green"
    Write-ColorOutput "===========================================================" "Green"

    Write-Host ""
    Write-ColorOutput "Next steps:" "Cyan"
    Write-Host "  1. Check CLAUDE.md for Chinese AI instructions"
    Write-Host "  2. Run 'claude' to start your Chinese development journey!"
    Write-Host ""
}

# Run main function
try {
    Install-ClaudeInit
}
catch {
    Write-ColorOutput "[ERROR] Error during setup: $($_.Exception.Message)" "Red"
    exit 1
}