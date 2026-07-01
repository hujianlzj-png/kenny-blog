# Gitee Pages 閮ㄧ讲鑴氭湰
# 鐢ㄦ硶: 鍦?PowerShell 涓繍琛?.\deploy.ps1
# 
# 浣跨敤鍓嶈鍏堥厤缃細
#   1. 鍦?Gitee 涓婂垱寤轰竴涓柊浠撳簱
#   2. 灏嗕笅闈㈢殑 GITEE_REPO 鏀逛负浣犵殑浠撳簱鍦板潃

$GITEE_USER = "swjtuannon"
$GITEE_REPO = "blog"

Write-Host "=== 1. 鏋勫缓绔欑偣 ===" -ForegroundColor Cyan
D:\Documents\涓汉鍗氬缃戠珯\bin\hugo.exe --minify
if ($LASTEXITCODE -ne 0) { Write-Host "鏋勫缓澶辫触" -ForegroundColor Red; exit 1 }

Write-Host "=== 2. 鍑嗗閮ㄧ讲鐩綍 ===" -ForegroundColor Cyan
$deployDir = "$env:TEMP\gitee_deploy"
if (Test-Path $deployDir) { Remove-Item -Recurse -Force $deployDir }
New-Item -ItemType Directory -Path $deployDir -Force | Out-Null

# 澶嶅埗 public/ 鍐呭鍒伴儴缃茬洰褰?Copy-Item -Recurse -Force public\* $deployDir

# 鍒囨崲鍒伴儴缃茬洰褰曞苟鍒濆鍖?git
Push-Location $deployDir
git init
git checkout -b pages
git add -A
git commit -m "deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"

Write-Host "=== 3. 鎺ㄩ€佸埌 Gitee ===" -ForegroundColor Cyan
Write-Host "妫€鏌ユ槸鍚﹀凡閰嶇疆杩滅▼浠撳簱..."
$remotes = git remote -v
if (-not $remotes) {
    git remote add origin "git@gitee.com:${GITEE_USER}/${GITEE_REPO}.git"
}

Write-Host ""
Write-Host "鎺ㄩ€佸墠璇风‘璁わ細" -ForegroundColor Yellow
Write-Host "  1. 宸插湪 Gitee 涓婂垱寤轰粨搴? ${GITEE_USER}/${GITEE_REPO}"
Write-Host "  2. 宸查厤缃?SSH Key 鎴栦釜浜鸿闂护鐗?
Write-Host ""
Write-Host "鎵ц鎺ㄩ€佸懡浠わ細" -ForegroundColor Green
Write-Host "  git push -f origin pages" -ForegroundColor White
Write-Host ""
Write-Host "鎺ㄩ€佸畬鎴愬悗锛屽湪 Gitee 浠撳簱璁剧疆 -> Pages 涓細" -ForegroundColor Yellow
Write-Host "  - 閮ㄧ讲鍒嗘敮: pages" -ForegroundColor White
Write-Host "  - 閮ㄧ讲鐩綍: /" -ForegroundColor White
Write-Host "  - 鐐瑰嚮銆屽惎鍔ㄣ€? -ForegroundColor White

Pop-Location
