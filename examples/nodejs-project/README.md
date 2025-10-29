# Node.js 项目示例

本示例展示如何在 Node.js 项目中配置和使用 Claude Code 中文开发套件。

## 🎯 项目结构

这是一个标准的 Node.js Express API 项目结构：

```
nodejs-project/
├── CLAUDE.md                     # Node.js 项目 AI 上下文
├── package.json                  # 项目依赖和脚本
├── package-lock.json            # 依赖锁定文件
├── .env.example                 # 环境变量示例
├── .gitignore                   # Git 忽略文件
├── src/
│   ├── index.js                 # 应用入口点
│   ├── app.js                   # Express 应用配置
│   ├── config/                  # 配置文件
│   │   ├── database.js          # 数据库配置
│   │   └── logger.js            # 日志配置
│   ├── routes/                  # API 路由
│   │   ├── index.js             # 路由入口
│   │   ├── users.js             # 用户相关接口
│   │   └── health.js            # 健康检查
│   ├── middleware/              # 中间件
│   │   ├── auth.js              # 认证中间件
│   │   ├── validation.js        # 数据验证中间件
│   │   └── errorHandler.js      # 错误处理中间件
│   ├── models/                  # 数据模型
│   │   ├── User.js              # 用户模型
│   │   └── index.js             # 模型入口
│   ├── services/                # 业务逻辑服务
│   │   ├── userService.js       # 用户服务
│   │   └── authService.js       # 认证服务
│   └── utils/                   # 工具函数
│       ├── logger.js            # 日志工具
│       └── helpers.js           # 辅助函数
├── tests/                       # 测试文件
│   ├── unit/                    # 单元测试
│   ├── integration/             # 集成测试
│   └── fixtures/                # 测试数据
├── docs/                        # 项目文档
│   └── ai-context/
│       └── project-structure.md # 项目结构说明
└── scripts/                     # 脚本文件
    ├── start.sh                 # 启动脚本
    └── test.sh                  # 测试脚本
```

## ⚙️ 技术栈

- **Node.js 18+** - JavaScript 运行时环境
- **Express.js 4.18+** - Web 应用框架
- **JavaScript/TypeScript** - 主要开发语言
- **MongoDB/PostgreSQL** - 数据库选项
- **Mongoose/Sequelize** - ORM/ODM
- **JWT** - 身份认证
- **Winston** - 日志管理
- **Jest** - 测试框架
- **ESLint + Prettier** - 代码质量和格式化
- **dotenv** - 环境变量管理
- **helmet** - 安全中间件
- **cors** - 跨域处理

## 🚀 快速开始

### 1. 复制项目模板
```bash
cp -r examples/nodejs-project my-nodejs-api
cd my-nodejs-api
```

### 2. 安装依赖
```bash
npm install
# 或使用 yarn
yarn install
```

### 3. 配置环境
```bash
cp .env.example .env
# 编辑 .env 文件设置数据库等配置
```

### 4. 启动开发
```bash
claude
# 现在可以使用中文化的Claude Code功能开发
```

## 💡 AI开发最佳实践

### Node.js特有的AI指令

在 `CLAUDE.md` 中已配置：

- **异步编程优先** - 所有数据库和网络操作使用 async/await
- **错误处理标准** - 使用 try-catch 和统一的错误处理中间件
- **中间件模式** - Express 中间件用于认证、验证、日志等
- **服务层分离** - 业务逻辑封装在服务层中
- **环境变量管理** - 敏感信息通过环境变量配置

### 常用开发工作流

1. **创建新的API端点**：
   ```bash
   # 使用Claude创建新的API路由
   /create-docs src/routes/products.js
   ```

2. **生成数据模型**：
   ```bash
   # 基于业务需求生成Mongoose/Sequelize模型
   /refactor models/Product.js
   ```

3. **添加中间件**：
   ```bash
   # 创建认证或验证中间件
   /create-docs middleware/rateLimit.js
   ```

## 📚 项目特定命令

### 开发服务器
```bash
# 启动开发服务器（热重载）
npm run dev
# 启动生产服务器
npm start
```

### 数据库操作
```bash
# 数据库迁移（如使用Sequelize）
npm run migrate
# 数据库种子数据
npm run seed
```

### 测试执行
```bash
# 运行所有测试
npm test
# 运行测试并生成覆盖率报告
npm run test:coverage
# 监听模式运行测试
npm run test:watch
```

### 代码质量检查
```bash
# ESLint 代码检查
npm run lint
# 自动修复可修复的问题
npm run lint:fix
# Prettier 代码格式化
npm run format
```

## 🔧 开发环境配置

### VSCode 配置
项目包含 `.vscode/settings.json` 配置：
- Node.js 调试配置
- 自动格式化配置
- 推荐扩展列表

### 环境变量配置
```bash
# .env 文件示例
NODE_ENV=development
PORT=3000
MONGODB_URI=mongodb://localhost:27017/myapp
JWT_SECRET=your-super-secret-jwt-key
LOG_LEVEL=info
```

## 🎯 项目定制

### 修改AI上下文
编辑 `CLAUDE.md` 文件，添加项目特定指令：
```markdown
### Node.js 项目特定规则
- 所有API端点必须添加速率限制中间件
- 数据库操作必须在服务层中实现
- 错误日志必须包含请求ID和用户ID
- 使用统一的时间格式（ISO 8601）
```

### 更新项目结构文档
编辑 `docs/ai-context/project-structure.md`，描述你的具体技术选型。

## 📋 API 设计标准

### RESTful API 规范
- 使用标准 HTTP 方法（GET, POST, PUT, DELETE）
- 使用复数名词作为资源名称
- 实现适当的 HTTP 状态码
- 统一的响应格式

### 响应格式
```javascript
// 成功响应
{
  "success": true,
  "data": {...},
  "message": "操作成功",
  "timestamp": "2024-01-01T00:00:00.000Z"
}

// 错误响应
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "输入数据验证失败",
    "details": [...]
  },
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

---

*这个示例为 Node.js 开发者提供了完整的 Claude Code 中文开发套件配置，帮助快速构建高质量的 Node.js Web 应用。*