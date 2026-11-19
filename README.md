# Joshua · 数字生命（个人品牌站）

数字生命 Joshua 对外个人品牌门面站，纯静态单文件 + 本地素材，无后端、无构建步骤、无 JS 依赖。

## 目录结构

```
joshua-site/
├── index.html          # 站点主文件（内联 CSS，响应式）
├── 404.html            # 404 占位页（同色系）
├── robots.txt          # 搜索引擎抓取规则
├── LICENSE             # 版权保留声明
├── .nojekyll           # 关闭 GitHub Pages 的 Jekyll 处理，保证静态资源原样发布
├── deploy-local.sh     # 本地一键提交推送脚本
├── README.md
└── assets/
    ├── favicon.png     # 站点图标（64×64 透明）
    ├── logo.png        # 图形标（128×128 透明）
    ├── avatar.png      # 头像（256×256 透明）
    ├── hero.jpg        # Hero 母版立绘（900px 宽）
    └── og-banner.jpg   # 社交分享横幅（1200px 宽）
```

## 本地预览

```bash
cd joshua-site
python3 -m http.server 8080
# 浏览器访问 http://localhost:8080
```

## GitHub Pages 部署

仓库已在 GitHub 创建（`supperJoshua/joshua-site`，公开）。

1. **补传图片与文件（首次部署前必做）**：MCP 通道仅入库文本文件，`assets/` 下 5 张位图需在本地已登录 GitHub 的机器补传。两种方式任选：

   - 一键脚本（推荐）：克隆仓库后，把交付包内全部文件覆盖进仓库目录，运行：

     ```bash
     git clone https://github.com/supperJoshua/joshua-site.git
     cd joshua-site
     # 覆盖本包文件（含 assets/ 五图）后执行：
     bash deploy-local.sh
     ```

   - 手动方式：

     ```bash
     git clone https://github.com/supperJoshua/joshua-site.git
     cd joshua-site
     # 把交付包 assets/ 下的 favicon.png、logo.png、avatar.png、hero.jpg、og-banner.jpg 放入 assets/
     git add assets/
     git commit -m "add site assets"
     git push
     ```

   补图前 Pages 预览会裂图，属正常。

2. 仓库 **Settings → Pages**：Source 选 `Deploy from a branch`，分支 `main`、目录 `/ (root)`，保存。
3. 等待部署完成，访问 `https://supperJoshua.github.io/joshua-site/`。
4. 上线后把 `index.html` 中 `og:image` 的相对路径改为公网绝对 URL：
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
