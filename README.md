# Joshua · 数字生命（个人品牌站）

数字生命 Joshua 对外个人品牌门面站，纯静态、无后端、无构建步骤、无 JS 依赖，响应式三档断点。

## 三种 HTML 形态（页面结构、文案、样式完全一致，仅图片引用方式不同）

| 文件 | 图片引用方式 | 体积 | 用途 |
|---|---|---|---|
| `index.html` | **公网绝对 URL**（已核验 200，字节与 SHA-1 与本地原图一致） | ~21KB | 仓库主文件。GitHub Pages 开启即可完整渲染，**无需任何二进制入库** |
| `index.live.html` | data URI 内嵌（自包含单文件） | ~412KB | 已托管为即时公网入口；也可用于单文件分发、离线打开、任意静态托管 |
| `index.relative.html` | 本地 `assets/` 相对路径 | ~21KB | 长期正式形态：位图入库后切换，由 Pages 独立缓存 |

> `og-banner.jpg` 是社交分享横幅，分享爬虫只认公网绝对位图 URL，因此三版都把 `og:image` / `twitter:image` 指向公网地址。

## 即时公网入口（不依赖 GitHub Pages）

自包含单文件版由平台 CDN 以 `text/html` 直接提供，已实测 HTTP 200 与完整渲染：

- **正式入口**（og / twitter 分享图已指向公网绝对 URL）：`https://aka.doubaocdn.com/s/wcqR83Vaxw`
- 同源备份：`https://aka.doubaocdn.com/s/P3c6fePbPc`

> 短链为临时地址，适合当前对外演示；长期门面请用 GitHub Pages 或自有域名。

## 目录结构

```
joshua-site/
├── index.html              # 公网 URL 引用版（Pages 直接可用）
├── index.live.html         # 自包含单文件版（data URI，已托管）
├── index.relative.html     # 本地 assets 相对路径版（正式形态备选）
├── 404.html                # 404 占位页（同色系）
├── robots.txt              # 搜索引擎抓取规则
├── LICENSE                 # 版权保留声明
├── .nojekyll               # 关闭 GitHub Pages 的 Jekyll 处理
├── .github/workflows/pages.yml  # Pages 部署工作流（手动触发）
├── deploy-local.sh         # Linux / macOS / Git-Bash 一键提交推送脚本（备选）
├── deploy-local.ps1        # Windows PowerShell 一键提交推送脚本（备选，需已装 Git）
├── README.md
└── assets/                 # 位图（当前未入库；index.html 走公网 URL，不依赖此目录）
    ├── favicon.png         # 64×64 透明
    ├── logo.png            # 128×128 透明
    ├── avatar.png          # 256×256 透明
    ├── hero.jpg            # 900×900 母版立绘
    └── og-banner.jpg       # 1200×675 分享横幅
```

## 本地预览

```bash
cd joshua-site
python3 -m http.server 8080
# 浏览器访问 http://localhost:8080
```

## GitHub Pages 部署

文本文件已全部入库，`index.html` 的图片引用为公网绝对 URL，因此**不再需要上传任何图片**。

### 方式 A：分支直部（推荐，步骤最少）

1. 仓库 **Settings → Pages**：Source 选 `Deploy from a branch`，分支 `main`、目录 `/ (root)`，保存。
2. 等待约 1 分钟，访问 `https://supperJoshua.github.io/joshua-site/`。
3. 如需把分享图改指自有域名，替换 `index.html` 中两处 `og:image` / `twitter:image` 即可。

### 方式 B：GitHub Actions 自动部署（已配好，需先启用 Pages）

仓库已含 `.github/workflows/pages.yml`（手动触发版）：

1. 仍需先在 **Settings → Pages** 把 Source 选为 `GitHub Actions`（一次即可）。
2. 之后到 **Actions → Deploy static site to GitHub Pages → Run workflow** 发布。

> 实测结论：Actions 内置 `GITHUB_TOKEN` 只能**部署**、不能**创建** Pages 站点。
> 开启 `enablement: true` 后报错 `Create Pages site failed: Resource not accessible by integration`。
> 因此自动创建 Pages 不可行，首次启用必须由仓库管理员在网页完成一次；故本工作流改为手动触发，避免每次 push 都产生失败记录。

### 长期演进：把图片本地化

当前 `index.html` 依赖公网图地址，属过渡方案。待有可执行 `git push` 的环境时：

```bash
git clone https://github.com/supperJoshua/joshua-site.git
cd joshua-site
cp /path/to/assets/*.png /path/to/assets/*.jpg assets/     # 补入五张原图
cp index.relative.html index.html                          # 切回相对路径版
git add . && git commit -m "chore: localize assets" && git push
```

或直接执行 `bash deploy-local.sh` / `powershell -ExecutionPolicy Bypass -File .\deploy-local.ps1`。

## 响应式断点

- 桌面 ≥1024：双栏 Hero、2 列能力、3 列产出、4 列渠道。
- 平板 640–1023：Hero 上下堆叠，产出 2 列，渠道 2 列。
- 移动 <640：全部单列，导航链接可横向滑动。

## 已核验事实

- 五张位图公网副本：`content-type` 分别为 `image/png` / `image/jpeg`，字节数与本地逐一相同，SHA-1 全部一致。
- 线上入口 Playwright 实测：HTTP 200、`text/html; charset=utf-8`、5 张图全部加载、无 console 错误、1440 与 390 双视口均无横向溢出。
- 仓库版 `index.html`：本地经公网加载五图成功，双视口无错误、无溢出；远端回读与本地字节完全一致。
- 仓库主文件与 README、`index.relative.html` 远端回读均与本地字节一致。

## 待补内容（需本人确认后填充，当前为占位）

- [ ] 各社交渠道真实链接与昵称（GitHub / 知乎 / 小红书 / 公众号）
- [ ] 首批可公开的文章、项目清单与标题链接
- [ ] 对外公开履历口径：学校、职业头衔、机构归属（当前按保守口径未上墙）
- [x] `og:image` 公网绝对 URL（已完成）
- [ ] 分身对话接入（阶段 C：RAG 检索闭环）

## 口径与合规

- 全站内容为个人经验与方法整理，不构成法律意见、投资建议或个案结论；页脚已挂免责口径。
- 未写入具体客户、债务人、个案细节、业绩数字与收益承诺。
- 字体：中文思源黑体 VF、英文 Montserrat，走平台 CDN；正式商用前请复核字体许可与长期可达性，必要时自托管字体子集。

## 已知限制

- 无后端、无表单、无访问统计；联系渠道为静态占位卡片。
- 移动端导航为横向滑动，未做汉堡菜单。
- 分身对话框为占位，未接真实检索与大模型。
- 图片走公网短链为过渡方案：短链若失效需重新上传并更新 `index.html` 中的地址。
