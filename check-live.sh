#!/usr/bin/env bash
# Joshua 个人站 · 在线入口健康巡检
# 用法：bash check-live.sh
# 输出每个入口的 HTTP 状态、content-type、字节数，并给出结论。

set -u

CDN_HTML="https://aka.doubaocdn.com/s/wcqR83Vaxw"
CDN_BACKUP="https://aka.doubaocdn.com/s/P3c6fePbPc"
GH_PREVIEW="https://htmlpreview.github.io/?https://raw.githubusercontent.com/supperJoshua/joshua-site/main/index.html"
GH_PAGES="https://supperJoshua.github.io/joshua-site/"
CDN_BANNER="https://aka.doubaocdn.com/s/VWTYcUPIu9"
CDN_FAVICON="https://aka.doubaocdn.com/s/nQlr2fkjLW"
CDN_LOGO="https://aka.doubaocdn.com/s/ncOI2E26eR"
CDN_HERO="https://aka.doubaocdn.com/s/9SUYyl6eod"
CDN_AVATAR="https://aka.doubaocdn.com/s/z2SLXikE8z"

check() {
  local label="$1" url="$2" expect="$3"
  local out code rest ctype size attempt=0
  while [ "$attempt" -lt 3 ]; do
    attempt=$((attempt+1))
    out=$(curl -sL --max-time 30 -o /tmp/_live_probe.bin \
          -w "%{http_code}|%{content_type}|%{size_download}" "$url" 2>/dev/null)
    code="${out%%|*}"
    if [ "$code" = "200" ] || [ "$expect" != "200" ]; then break; fi
  done
  rest="${out#*|}"; ctype="${rest%%|*}"; size="${rest#*|}"
  local verdict="FAIL"
  if [ "$code" = "$expect" ]; then verdict="OK"; fi
  if [ "$expect" = "200" ] && [ "${size:-0}" -lt 1000 ] 2>/dev/null; then verdict="EMPTY"; fi
  printf '%-22s %-5s %-26s %10s B   %s\n' "$label" "$code" "$ctype" "$size" "$verdict"
}

echo "Joshua 个人站 · 入口巡检  $(date '+%Y-%m-%d %H:%M:%S')"
echo "--------------------------------------------------------------"
check "CDN 正式入口"      "$CDN_HTML"    200
check "CDN 备份入口"      "$CDN_BACKUP"  200
check "GitHub 内容入口"   "$GH_PREVIEW"  200
check "GitHub Pages"      "$GH_PAGES"    200
echo "--------------------------------------------------------------"
check "分享横幅"          "$CDN_BANNER"  200
check "favicon"           "$CDN_FAVICON" 200
check "logo"              "$CDN_LOGO"    200
check "hero"              "$CDN_HERO"    200
check "avatar"            "$CDN_AVATAR"  200
echo "--------------------------------------------------------------"
echo "说明："
echo "  · GitHub Pages 显示 404 = 尚未在 Settings 启用 Pages（预期状态，需仓库管理员一次操作）"
echo "  · 任一 CDN 短链 FAIL = 需重新上传对应文件并更新 index.html 中的引用"
echo "  · GitHub 内容入口依赖 raw.githubusercontent.com 可达性，国内环境可能较慢"
