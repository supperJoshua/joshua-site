# 在线入口与托管通道实测

> 最后一次实测：2026-11-23，全部用 `curl -sL` GET + Playwright 双视口验证。

## 现在能对外访问的入口

### 入口 A · 平台 CDN（国内速度最好，分享用这个）

```
https://aka.doubaocdn.com/s/wcqR83Vaxw
```

- 自包含单文件版（`index.live.html`，412,299 B），`text/html; charset=utf-8`，HTTP 200。
- 图片已内嵌为 data URI，**不依赖任何外链**，单文件即可完整渲染。
- 备份：`https://aka.doubaocdn.com/s/P3c6fePbPc`（412,263 B，og 图走相对路径）

### 入口 B · GitHub 内容驱动（长效，改仓库即生效）

```
https://htmlpreview.github.io/?https://raw.githubusercontent.com/supperJoshua/joshua-site/main/index.html
```

- 由 `main` 分支的 `index.html` 实时渲染，**推送仓库后立即更新，无需重传文件**。
- Playwright 实测：`title = Joshua · 数字生命`、`h1 = JOSHUA / 张健华`、5 张图全部加载（128/900/256/256/128）。
- 依赖 `raw.githubusercontent.com` 可达性，国内可能偏慢，适合作为长效/可维护入口与分享备用。

### 待启用 · GitHub Pages

```
https://supperJoshua.github.io/joshua-site/
```

当前 **404**。原因与结论见下。

## 通道实测结论（避免重复踩坑）

| 通道 | 结果 | 说明 |
|---|---|---|
| 平台文件 CDN | ✅ 可用 | 返回 `text/html`，可直接当静态网页托管 |
| `htmlpreview.github.io` | ✅ 可用 | 通过 iframe 渲染仓库 raw HTML，跟随 main 更新 |
| GitHub Pages（分支直部） | ⏸ 需一次人工 | Settings → Pages 未启用，线上 404 |
| GitHub Pages（Actions 自动创建） | ❌ 权限拒绝 | 见下 |
| `cdn.jsdelivr.net` | ❌ | HTML 被降级为 `text/plain`，浏览器显示源码 |
| `cdn.statically.io` | ❌ | 网络不可达（code 000） |
| `raw.githack.com` / `rawcdn.githack.com` | ❌ | 网络不可达（code 000） |
| GitHub MCP 二进制上传 | ❌ | content 仅接受文本字符串，服务端统一 base64，无法无损承载位图 |

### Actions 自动创建 Pages 为何失败

两次运行（run 44975992410、44976309372）的 annotation 均为：

```
Get Pages site failed. Error: Not Found
Create Pages site failed. Error: Resource not accessible by integration
```

即 Actions 内置 `GITHUB_TOKEN` 只能**部署已存在的 Pages 站点**，**不能创建**。开启 `enablement: true` 亦无效。
因此 `.github/workflows/pages.yml` 已改为 `workflow_dispatch` 手动触发，避免每次 push 产生失败记录。
首次启用必须由仓库管理员在网页完成一次：**Settings → Pages → Source**（`Deploy from a branch` / main / `/ (root)`，或 `GitHub Actions`）。

## 巡检

```bash
bash check-live.sh          # 逐个检查入口与五张位图，输出状态表（含 3 次重试）
```

- `GitHub Pages 404` 属预期，待启用后应变 200。
- 任一 CDN 短链 `FAIL` → 重新上传对应文件，并把新地址替换进 `index.html` 的引用处。

## 更新站点的两条路

| 想改什么 | 怎么做 |
|---|---|
| 只改文案/排版 | 改 `index.html`（及 `index.live.html`），推送到 `main` → 入口 B 立即生效 |
| 想让入口 A 也更新 | 重新上传 `index.live.html`，用新短链替换入口 A 地址 |
| 想彻底本地化图片 | 有 git 环境时按 README「长期演进」把五图入库并切 `index.relative.html` |
