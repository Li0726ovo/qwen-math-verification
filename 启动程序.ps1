$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Host "正在启动 Lean4Generator..." -ForegroundColor Green

# 检查是否安装了依赖
if (-not (Get-Module -ListAvailable -Name PySide6)) {
    Write-Host "检测到依赖未安装，正在安装..." -ForegroundColor Yellow
    pip install -r requirements.txt
}

# 启动程序
python app.py

if ($LASTEXITCODE -ne 0) {
    Write-Host "程序启动失败，请检查错误信息" -ForegroundColor Red
    Read-Host "按回车键退出"
}
