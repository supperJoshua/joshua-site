# Joshua 个人站 · Windows PowerShell 一键提交推送脚本（备选路线，需已安装 Git）
# 用法：在仓库根目录右键“在终端中打开”，执行  powershell -ExecutionPolicy Bypass -File .\deploy-local.ps1

$ErrorActionPreference = "Stop"
$Repo = "https://github.com/supperJoshua/joshua-site.git"

# 1. 确认在 git 仓库内
if (-not (Test-Path ".git")) {
    Write-Host "未检测到 .git 目录。请先克隆仓库：" -ForegroundColor Yellow
    Write-Host "  git clone $Repo"
    Write-Host "  cd joshua-site"
    Write-Host "  把本包内文件覆盖进目录后，重新运行本脚本"
    exit 1
}

# 2. 绑定远端（若尚未绑定）
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    git remote add origin $Repo
}

# 3. 暂存站点文件
git add index.html 404.html robots.txt LICENSE README.md .nojekyll assets/ deploy-local.ps1

# 4. 提交（无改动则跳过）
$staged = git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    git commit -m "deploy: update site files and assets"
} else {
    Write-Host "没有需要提交的改动。"
}

# 5. 推送 main 分支
git branch -M main
git push -u origin main

Write-Host "完成。随后到仓库 Settings → Pages，Source 选 main 分支、/ (root) 开启站点。" -ForegroundColor Green
