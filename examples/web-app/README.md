# Web 应用示例

本示例展示如何在纯静态 Web 项目中配置和使用 Claude Code 中文开发套件。

## 🎯 项目结构

这是一个现代纯静态 Web 应用项目结构：

```
web-app/
├── CLAUDE.md                     # Web 项目 AI 上下文
├── index.html                   # 应用入口页面
├── .gitignore                   # Git 忽略文件
├── manifest.json                # Web App 清单
├── robots.txt                   # 搜索引擎配置
├── humans.txt                   # 项目团队信息
├── assets/                      # 静态资源
│   ├── css/                     # 样式文件
│   │   ├── main.css             # 主样式文件
│   │   ├── components.css       # 组件样式
│   │   └── responsive.css       # 响应式样式
│   ├── js/                      # JavaScript 文件
│   │   ├── main.js              # 主应用逻辑
│   │   ├── components/          # 组件脚本
│   │   │   ├── navbar.js        # 导航栏组件
│   │   │   ├── modal.js         # 模态框组件
│   │   │   └── carousel.js      # 轮播图组件
│   │   ├── utils/               # 工具函数
│   │   │   ├── helpers.js       # 辅助函数
│   │   │   ├── api.js           # API 调用封装
│   │   │   └── storage.js       # 本地存储工具
│   │   └── config.js            # 配置文件
│   ├── images/                  # 图片资源
│   │   ├── icons/               # 图标文件
│   │   ├── banners/             # 横幅图片
│   │   └── content/             # 内容图片
│   ├── fonts/                   # 字体文件
│   └── data/                    # 静态数据
│       └── content.json         # 页面内容数据
├── pages/                       # 页面文件
│   ├── about.html               # 关于页面
│   ├── contact.html             # 联系页面
│   └── portfolio.html           # 作品展示页面
├── components/                  # 可复用组件
│   ├── header.html              # 页头组件
│   ├── footer.html              # 页脚组件
│   ├── navbar.html              # 导航组件
│   └── card.html                # 卡片组件
├── styles/                      # 样式源文件
│   ├── base/                    # 基础样式
│   │   ├── reset.css            # 重置样式
│   │   ├── typography.css       # 排版样式
│   │   └── variables.css        # CSS 变量
│   ├── layout/                  # 布局样式
│   │   ├── grid.css             # 网格布局
│   │   ├── header.css           # 页头样式
│   │   └── footer.css           # 页脚样式
│   └── components/              # 组件样式
│       ├── buttons.css          # 按钮样式
│       ├── cards.css            # 卡片样式
│       └── forms.css            # 表单样式
├── scripts/                     # 脚本源文件
│   ├── vendor/                  # 第三方库
│   │   └── swiper.min.js        # 轮播库
│   ├── modules/                 # 模块化脚本
│   │   ├── router.js            # 路由管理
│   │   ├── storage.js           # 存储管理
│   │   └── animation.js         # 动画效果
│   └── init.js                  # 初始化脚本
├── tests/                       # 测试文件
│   ├── unit/                    # 单元测试
│   └── e2e/                     # 端到端测试
├── docs/                        # 项目文档
│   └── ai-context/
│       └── project-structure.md # 项目结构说明
└── tools/                       # 构建工具
    ├── build.js                 # 构建脚本
    └── serve.js                 # 开发服务器
```

## ⚙️ 技术栈

- **HTML5** - 语义化标记
- **CSS3** - 现代样式和动画
- **Vanilla JavaScript (ES6+)** - 原生JavaScript开发
- **CSS Grid & Flexbox** - 现代布局技术
- **Web Components** - 可复用组件
- **Service Worker** - 离线支持
- **LocalStorage/SessionStorage** - 本地数据存储
- **Fetch API** - 网络请求
- **Intersection Observer** - 懒加载
- **CSS Custom Properties** - 主题定制

## 🚀 快速开始

### 1. 复制项目模板
```bash
cp -r examples/web-app my-web-app
cd my-web-app
```

### 2. 启动开发服务器
```bash
# 使用 Python 启动简单服务器
python -m http.server 8000

# 或使用 Node.js http-server
npx http-server . -p 8000 -c-1

# 或使用内置的构建工具
node tools/serve.js
```

### 3. 开始开发
```bash
claude
# 现在可以使用中文化的Claude Code功能开发
```

### 4. 构建生产版本
```bash
node tools/build.js
```

## 💡 AI开发最佳实践

### Web项目特有的AI指令

在 `CLAUDE.md` 中已配置：

- **语义化HTML优先** - 使用正确的HTML5语义标签
- **性能优化** - 图片懒加载、代码分割、资源压缩
- **响应式设计** - 移动优先的响应式布局
- **无障碍支持** - ARIA标签和键盘导航支持
- **SEO优化** - 合理的meta标签和结构化数据

### 常用开发工作流

1. **创建新页面**：
   ```bash
   # 使用Claude创建新的HTML页面
   /create-docs pages/services.html
   ```

2. **添加新组件**：
   ```bash
   # 创建可复用的Web组件
   /create-docs components/testimonial.html
   ```

3. **样式优化**：
   ```bash
   # 优化CSS样式和响应式布局
   /refactor assets/css/main.css
   ```

## 📚 项目特定命令

### 开发服务器
```bash
# 启动开发服务器
node tools/serve.js

# 或者使用Python
python -m http.server 8000
```

### 构建和优化
```bash
# 构建生产版本
node tools/build.js

# 图片优化
node tools/optimize-images.js

# CSS 压缩
node tools/minify-css.js
```

### 测试
```bash
# 运行单元测试
npm run test:unit

# 运行端到端测试
npm run test:e2e

# 性能测试
npm run test:performance
```

## 🎨 设计系统

### CSS 变量配置
```css
:root {
  /* 颜色系统 */
  --primary-color: #3b82f6;
  --secondary-color: #64748b;
  --accent-color: #f59e0b;
  --text-primary: #1f2937;
  --text-secondary: #6b7280;
  --bg-primary: #ffffff;
  --bg-secondary: #f9fafb;
  
  /* 字体系统 */
  --font-family-primary: 'Inter', sans-serif;
  --font-family-mono: 'JetBrains Mono', monospace;
  
  /* 间距系统 */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 2rem;
  --spacing-xl: 4rem;
  
  /* 断点系统 */
  --breakpoint-sm: 640px;
  --breakpoint-md: 768px;
  --breakpoint-lg: 1024px;
  --breakpoint-xl: 1280px;
}
```

### 响应式设计原则
- **移动优先** - 基础样式针对移动设备，逐步增强
- **弹性布局** - 使用Flexbox和Grid实现自适应布局
- **相对单位** - 优先使用rem、em、vh、vw等相对单位
- **媒体查询** - 合理设置断点，优化不同设备体验

## 🔧 性能优化

### 图片优化
- 使用现代图片格式（WebP、AVIF）
- 实现懒加载和渐进式加载
- 提供多种分辨率版本

### 代码优化
- CSS和JavaScript压缩
- 移除未使用的代码
- 实现代码分割和按需加载

### 缓存策略
- 设置合适的Cache-Control头
- 使用Service Worker实现离线支持
- 利用浏览器缓存机制

## 🎯 项目定制

### 修改AI上下文
编辑 `CLAUDE.md` 文件，添加项目特定指令：
```markdown
### Web项目特定规则
- 所有图片必须包含alt属性和懒加载
- 使用语义化HTML5标签
- CSS使用BEM命名规范
- JavaScript模块必须支持ES6+语法
- 所有交互元素必须支持键盘导航
```

### 更新项目结构文档
编辑 `docs/ai-context/project-structure.md`，描述你的具体技术选型。

## 📋 浏览器兼容性

### 支持的浏览器
- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+

### Polyfill 策略
根据目标浏览器使用必要的polyfill，确保功能兼容性。

---

*这个示例为 Web 开发者提供了完整的 Claude Code 中文开发套件配置，帮助快速构建高质量的纯静态 Web 应用。*