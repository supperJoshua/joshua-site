# Joshua · 数字生命（个人品牌站）

数字生命 Joshua 对外个人品牌门面站，纯静态、无后端、无构建步骤、无 JS 依赖，响应式三档断点。

## 两种 HTML 形态

| 文件 | 形态 | 体积 | 用途 |
|---|---|---|---|
| `index.html` | **自包含单文件版**：favicon / logo / hero / avatar 已内嵌为 data URI，不依赖本地图片文件 | ~412KB | 网页端上传这一个文件即可带图上线，**推荐** |
| `index.relative.html` | 相对路径版：图片引用 `assets/` 目录 | ~21KB | 正式部署、后续换图或接入构建流程时使用 |

> 两版页面结构、文案、样式完全一致，仅图片引用方式不同。`og-banner.jpg` 是社交分享横幅，分享爬虫不识别 data URI，因此无论哪版都需作为独立文件放在 `assets/` 下。

## 目录结构

```
joshua-site/
├── index.html          # 自包含单文件版（内嵌 favicon/logo/hero/avatar）
├── index.relative.html # 相对路径版（引用 assets/，供正式部署/换图）
├── 404.html            # 404 占位页（同色系）
├── robots.txt         # 搜索引擎抓取规则
├── LICENSE             # 版权保留声明
├── .nojekyll          # 关闭 GitHub Pages 的 Jekyll 处理
├── deploy-local.sh     # Linux / macOS / Git-Bash 一键提交推送脚本（备选）
├── deploy-local.ps1    # Windows PowerShell 一键提交推送脚本（备选，需已装 Git）
├── README.md
└── assets/
    ├── favicon.png     # 站点图标（64×64 透明）
    ├── logo.png        # 图形标（128×128 透明）
    ├── avatar.png      # 头像（256×256 透明）
    ├── hero.jpg        # Hero 母版立绘（900px 宽）
    └── og-banner.jpg   # 社交分享横幅（1200px 宽，必须独立上传）
```

## 本地预览

```bash
cd joshua-site
python3 -m http.server 8080
# 浏览器访问 http://localhost:8080
```

## GitHub Pages 部署

仓库已在 GitHub 创建（`supperJoshua/joshua-site`，公开）。文本文件已入库，位图与 Pages 开关需在已登录 GitHub 的环境完成。

### 方式一：网页端上传自包含单文件（推荐，操作最少，无需安装 Git）

适合本机未装 Git 的 Windows / Mac：

1. 浏览器登录 GitHub，打开仓库 `https://github.com/supperJoshua/joshua-site`。
2. **替换主文件**：进入 `index.html` → 铅笔编辑（或 Add file → Upload files），上传本包 `index.html`（自包含版）覆盖远端同名文件，提交。
3. **补分享横幅**：进入 `assets/` 目录（地址栏访问 `https://github.com/supperJoshua/joshua-site/new/main/assets`），仅上传 `og-banner.jpg` 一张。
   - favicon、logo、hero、avatar 已内嵌进 `index.html`，无需再传。
4. 页面下方填写提交信息（如 `deploy: self-contained index + og banner`），点 **Commit changes**。

### 方式二：网页端上传相对路径完整版

1. 把本包 `index.relative.html` 重命名为 `index.html`。
2. Add file → Upload files，连同 `assets/` 下 5 张图一起上传，路径前缀保持 `assets/`。
3. 提交。

### 方式三：Git 命令行（备选，需先安装 Git）

```bash
git clone https://github.com/supperJoshua/joshua-site.git
cd joshua-site
# 覆盖本包文件后，按系统执行其一：
bash deploy-local.sh                 # Linux / macOS / Git-Bash
powershell -ExecutionPolicy Bypass -File .\deploy-local.ps1   # Windows PowerShell
```

手动等价操作：`git add . && git commit -m "deploy site" && git push`。

> 补图 / 替换主文件前，Pages 预览可能裂图，属正常现象。

### 开启 Pages

1. 仓库 **Settings → Pages**：Source 选 `Deploy from a branch`，分支 `main`、目录 `/ (root)`，保存。
2. 等待部署完成，访问 `https://supperJoshua.github.io/joshua-site/`。
3. 上线后把 `index.html` 中 `og:image`、`twitter:image` 的相对路径改为公网绝对 URL：
   `https://supperJoshua.github.io/joshua-site/assets/og-banner.jpg`。

## 响应式断点

- 桌面 ≥1024：双栏 Hero、2 列能力、3 列产出、4 列渠道。
- 平板 640–1023：Hero 上下堆叠，产出 2 列，渠道 2 列。
- 移动 <640：全部单列，导航链接可横向滑动。

## 待补内容（需本人确认后填充，当前为占位）

- [ ] 各社交渠道真实链接与昵称（GitHub / 知乎 / 小红书 / 公众号）
- [ ] 首批可公开的文章、项目清单与标题链接
- [ ] 对外公开履历口径：学校、职业头衔、机构归属（当前按保守口径未上墙）
- [ ] `og:image` 公网绝对 URL
- [ ] 分身对话接入（阶段 C：RAG 检索闭环）

## 口径与合规

- 全站内容为个人经验与方法整理，不构成法律意见、投资建议或个案结论；页脚已挂免责口径。
- 未写入具体客户、债务人、个案细节、业绩数字与收益承诺。
- 字体：中文思源黑体 VF、英文 Montserrat，走平台 CDN；正式商用前请复核字体许可与长期可达性，必要时自托管字体子集。

## 已知限制

- 无后端、无表单、无访问统计；联系渠道为静态占位卡片。
- 移动端导航为横向滑动，未做汉堡菜单。
- 分身对话框为占位，未接真实检索与大模型。
- 自包含版把四张图内嵌进 HTML，单文件体积较大；后续若图片增多，建议切回相对路径版并由 Pages 独立缓存。
