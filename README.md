# Claude Code 中文开发套件

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Language: 中文](https://img.shields.io/badge/Language-%E4%B8%AD%E6%96%87-red.svg)](README.md)
[![Version](https://img.shields.io/github/v/release/domonic18/claude-init)](https://github.com/domonic18/claude-init/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/domonic18/claude-init/total)](https://github.com/domonic18/claude-init/releases)
[![Stars](https://img.shields.io/github/stars/domonic18/claude-init)](https://github.com/domonic18/claude-init/stargazers)
[![Forks](https://img.shields.io/github/forks/domonic18/claude-init)](https://github.com/domonic18/claude-init/network/members)
[![Issues](https://img.shields.io/github/issues/domonic18/claude-init)](https://github.com/domonic18/claude-init/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)](README.md)
[![Claude Code](https://img.shields.io/badge/Compatible-Claude%20Code-blue)](https://github.com/anthropics/claude-code)
[![MCP](https://img.shields.io/badge/Support-MCP%20Servers-green)](README.md#mcp-服务器支持)

<div align="center">

🚀 **为中国开发者定制的 Claude Code 智能开发环境**

[快速开始](#-快速开始) • [使用方法](#-使用方法) • [使用反馈](#-使用反馈) • [更新日志](CHANGELOG.md)

---

🚀 **新增智谱AI引擎**: 最新集成了 **[智谱大模型 (BigModel.cn)](https://www.bigmodel.cn/claude-code?ic=H0RNPV3LNZ)**。其旗舰 **GLM-4.5** 模型拥有媲美 Claude 的代码能力，并提供极具吸引力的包月服务，是入门和高频使用的绝佳选择。 **[点此注册即领2000万免费Tokens →](https://www.bigmodel.cn/claude-code?ic=EB0ANOYGCW)**
</div>

## ✨ 特性

### 🎯 完全中文化
- **中文 AI 指令** - 所有 AI 上下文和提示完全中文化
- **中文文档系统** - 三层文档架构的中文版本
- **中文错误信息** - 友好的中文错误提示和帮助
- **中文安装体验** - 从安装到配置全程中文

### 🧠 智能上下文管理
- **三层文档架构** - 基础层/组件层/功能层分级管理
- **自动上下文注入** - 子智能体自动获取项目上下文
- **智能文档路由** - 根据任务复杂度加载适当文档
- **跨会话状态管理** - 智能任务交接和状态保持

### 🔧 开发工具集成
- **Hook 系统** - 中文化的自动化 Hook 脚本
- **MCP 服务器支持** - Gemini 咨询、Context7 文档等
- **Skills 扩展** - 模块化的能力扩展系统

### 📚 完整模板库
- **项目模板** - 多种编程语言的项目结构模板
- **文档模板** - 标准化的中文文档模板
- **配置示例** - 开箱即用的配置文件
- **示例项目** - Python、Node.js、Web 应用完整示例

## 🚀 快速开始

### 一键安装

#### Linux / macOS
切换到您的工程项目目录下，执行以下命令：

```bash
curl -fsSL https://raw.githubusercontent.com/domonic18/ai-claude-init/main/install.sh | bash
```

#### Windows
切换到您的工程项目目录下，在PowerShell中执行以下命令：

```powershell
irm https://raw.githubusercontent.com/domonic18/ai-claude-init/main/install.ps1 | iex
```

> 说明：该命令会在您的项目目录下创建`.claude`目录，并自动复制相关的command、hook、agent、skill等文件。

> **注意**：如果遇到PowerShell执行策略限制，请先运行：
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### 手动安装

#### Linux / macOS
```bash
# 克隆仓库
git clone https://github.com/domonic18/ai-claude-init.git
cd ai-claude-init

# 运行安装脚本
./setup.sh
```

#### Windows
```powershell
# 克隆仓库
git clone https://github.com/domonic18/ai-claude-init.git
cd ai-claude-init

# 运行安装脚本
.\setup.ps1
```

> **注意**：如果遇到PowerShell执行策略限制，请先运行：
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

> **权限问题处理**：如果遇到文件访问权限问题，请尝试：
> ```powershell
> # 以管理员身份运行 PowerShell
> Start-Process PowerShell -Verb RunAs
>
> # 或者使用 Bypass 策略临时运行
> powershell -ExecutionPolicy Bypass -File .\setup.ps1
> ```

## 💡建议

- 如果您**已有工程**项目，想加速您的开发效率，那么建议您参考[`1-建立工程上下文`](README.md#1-建立工程上下文)。
- 如果您是**新建开发**项目，那么建议您参考[`2-创建项目目录`](README.md#2-创建项目目录)。
- 如果您只是想使用`Claude Code`的扩展功能(如`MCP`、`command`、`skill`等)，那么建议您参考:
  - [`3-快捷的斜杠命令`](README.md#3-快捷的斜杠命令)
  - [`4-使用 Context7 查询最新的API文档`](README.md#4-使用-context7-查询最新的api文档)
  - [`5-使用 Skill 生成工作周报`](README.md#5-使用-skill-生成工作周报)
- 如果您想系统地学习`Claude Code`的使用方法和最佳实践，那么建议您参考[`深入学习`](README.md#深入学习)。
- 如果您想了解`Claude Code`的skill开发方法，那么建议您参考[`skill开发`](README.md#skill开发)。

## 📖 使用方法

### 1. 建立工程上下文

`CLAUDE.md` 是项目的核心文档，用于建立 AI 助手对项目的理解：

**作用：**
- 让 AI 助手了解项目架构、编码规范、安全要求
- 提供项目特定的上下文信息
- 确保 AI 助手给出符合项目标准的建议

**使用方法：**
1. 在项目根目录创建或编辑 `CLAUDE.md` 文件
2. 添加项目相关的核心信息
3. 保存后，后续 AI 对话会自动使用该文档

> 说明：你也可以通过提示词，驱动大模型根据你的项目文件进行CLAUDE.md文档的更新。

### 2. 创建项目目录

如果你是从零开始创建项目目录，那么可以借助该项目预置的项目模板，快速创建对应的项目目录：

**使用方法：**
```bash
# 复制示例项目
cp -r docs/examples/python-project my-new-project
cd my-new-project

# 开始使用
claude
```

**可用示例：**
- 🐍 **Python 项目** - FastAPI Web 应用、数据科学项目
- 🟢 **Node.js 项目** - Express.js API 服务、React 全栈应用
- 🌐 **Web 应用** - 前后端分离架构、移动端适配


### 3. 快捷的斜杠命令

`Claude Code` 提供了丰富的斜杠命令，直接在对话中输入：

```bash
# 在 Claude Code 中输入以下命令

# 代码质量检查
/code-review               # 多专家角度代码审查

# 代码提交管理
/gitcommit                 # 智能分析代码改动并分批提交

# AI 咨询
/gemini-consult            # 与 Gemini 深入对话咨询

# 文档管理
/create-docs               # 创建 AI 优化文档结构
/update-docs               # 保持文档与代码同步

# 代码维护
/refactor                  # 智能重构代码

# 会话管理
/handoff                   # 保留上下文和任务状态

# 工具状态
/mcp-status                # 检查 MCP 服务器状态
```

### 4. 使用 Context7 查询最新的API文档

Context7 提供最新开源库文档查询功能，需要配置 API Key：

**配置 API Key：**
```bash
# 获取 Context7 API Key
# 访问 https://context7.com 注册并获取 API Key

# 设置环境变量
# 编辑.claude 目录下的settings.local.json文件，替换其中的`YOUR_CONTEXT7_API_KEY`为你的Context7 API Key：
"context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp", "--api-key", "YOUR_CONTEXT7_API_KEY"]
    }
```

**使用方法：**
```bash
# 在 Claude Code 中直接询问
"React 的最新 hooks 用法"
"FastAPI 的依赖注入怎么用"
"Docker 容器网络配置"
```

### 5. 使用 Skill 生成工作周报

**使用方法：**
```bash
# 在 Claude Code 中直接说
"生成昨天的日报"
"生成上周的周报"
"生成2025-10-30的日报"
"生成上周的周报并发送到企微机器人"
```

## 📚 深入学习
除了上述常用技能，你也可以通过如下教程，系统地学习 `Claude Code`。

**[Claude Code 中文课程指南](docs/tutorials/README-中文课程指南.md)**

课程包含：
- Claude Code 核心概念和导航
- 斜杠命令和集成系统详解
- 开发工作流和最佳实践
- 智能任务系统使用
- 高级协同实现方法

## 🔧 高级功能

如需了解以下高级功能的详细原理和使用方法，请查看 [高级功能详解](docs/tutorials/高级功能详解.md)：

- **智能上下文管理原理** - 三层文档架构详解
- **Hook 系统配置** - 自定义自动化脚本
- **自定义通知音效** - 替换系统音效方法
- **安全扫描机制** - MCP 调用安全检查
- **Skills 系统开发** - 创建自定义技能

## 💬 使用反馈

### 🐛 问题反馈
**遇到问题？** [提交 Issue](https://github.com/domonic18/claude-init/issues)

**常见问题类型：**
- 安装失败或错误
- MCP 服务器无法使用
- Hook 脚本不工作
- 中文显示异常
- 功能建议和改进

### 💡 功能建议
**想要新功能？** [发起讨论](https://github.com/domonic18/claude-init/discussions)

**建议包含：**
- 功能描述和使用场景
- 期望的工作方式
- 类似工具的参考

### 🤝 参与贡献
欢迎提交代码、文档改进和翻译优化！

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

- [Claude Code Development Kit](https://github.com/peterkrueck/Claude-Code-Development-Kit) - 原始项目
- [Claude-init中文项目](https://github.com/cfrs2005/claude-init) - 首个中文翻译项目
- [Anthropic](https://www.anthropic.com/) - Claude Code 平台
- 所有贡献者和中文开发社区
