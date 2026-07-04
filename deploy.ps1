# 个人博客部署脚本 — 同时推送 GitHub + Gitee
# 用法: .\deploy.ps1 [-Message "自定义commit信息"]

param(
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  个人博客部署 · Hugo + Git" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# ─── 1. 构建站点 ───
Write-Host "[1/4] 构建 Hugo 站点..." -ForegroundColor Yellow
$hugoPath = "D:\Documents\个人博客网站\bin\hugo.exe"
if (-not (Test-Path $hugoPath)) {
    $hugoPath = (Get-Command hugo -ErrorAction SilentlyContinue).Source
}
if (-not $hugoPath) {
    Write-Host "  ✗ 未找到 hugo，请安装 Hugo 或将 hugo.exe 放到 bin/ 目录" -ForegroundColor Red
    exit 1
}
Push-Location $projectRoot
& $hugoPath --minify --cleanDestinationDir
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ✗ Hugo 构建失败" -ForegroundColor Red
    Pop-Location
    exit 1
}
Write-Host "  ✓ 构建完成" -ForegroundColor Green

# ─── 2. 提交源码到 Git ───
Write-Host "`n[2/4] 提交源码变更..." -ForegroundColor Yellow
if (-not $Message) {
    $Message = "deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}
git add -A
$hasChanges = git status --porcelain
if ($hasChanges) {
    git commit -m $Message
    Write-Host "  ✓ 提交: $Message" -ForegroundColor Green
} else {
    Write-Host "  · 无变更，跳过提交" -ForegroundColor Gray
}

# ─── 3. 推送到 GitHub ───
Write-Host "`n[3/4] 推送到 GitHub..." -ForegroundColor Yellow
$githubRemote = git remote get-url github 2>$null
if ($githubRemote) {
    git push github main 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ GitHub 推送成功" -ForegroundColor Green
    } else {
        Write-Host "  ✗ GitHub 推送失败，请检查 SSH Key 和网络" -ForegroundColor Red
    }
} else {
    Write-Host "  · 未配置 github 远程仓库，跳过" -ForegroundColor Gray
}

# ─── 4. 推送到 Gitee ───
Write-Host "`n[4/4] 推送到 Gitee..." -ForegroundColor Yellow
$giteeRemote = git remote get-url origin 2>$null
if ($giteeRemote) {
    git push origin main 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Gitee 推送成功" -ForegroundColor Green
        Write-Host "`n  如需更新 Gitee Pages，请前往: https://gitee.com/swjtuannon/kenny-blog/pages" -ForegroundColor Cyan
    } else {
        Write-Host "  ✗ Gitee 推送失败" -ForegroundColor Red
    }
} else {
    Write-Host "  · 未配置 origin 远程仓库，跳过" -ForegroundColor Gray
}

Pop-Location
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  部署流程完成" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
