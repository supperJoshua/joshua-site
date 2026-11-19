#!/usr/bin/env bash
# Joshua 个人站 · 本地一键提交推送脚本
# 用法：在仓库根目录执行  bash deploy-local.sh
set -euo pipefail

REPO="https://github.com/supperJoshua/joshua-site.git"

# 1. 确认在 git 仓库内
if [ ! -d .git ]; then
  echo "未检测到 .git 目录。请先克隆仓库："
  echo "  git clone $REPO"
  echo "  cd joshua-site"
  echo "  把本包内文件覆盖进目录后，重新运行本脚本"
  exit 1
fi

# 2. 绑定远端（若尚未绑定）
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$REPO"
fi

# 3. 暂存站点文件
git add index.html 404.html robots.txt LICENSE README.md .nojekyll assets/

# 4. 提交（无改动则跳过）
if git diff --cached --quiet; then
  echo "没有需要提交的改动。"
else
  git commit -m "deploy: update site files and assets"
fi

# 5. 推送 main 分支
git branch -M main
git push -u origin main

echo "完成。随后到仓库 Settings → Pages，Source 选 main 分支、/ (root) 开启站点。"
