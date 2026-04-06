Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Lean4Generator 安装包构建脚本" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/3] 检查 Python 环境..." -ForegroundColor Yellow
$pythonVersion = python --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "错误: 未找到 Python" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}
Write-Host "Python 版本: $pythonVersion" -ForegroundColor Green
Write-Host ""

Write-Host "[2/3] 安装 PyInstaller..." -ForegroundColor Yellow
pip install pyinstaller
if ($LASTEXITCODE -ne 0) {
    Write-Host "警告: PyInstaller 安装失败，可能已安装" -ForegroundColor Yellow
} else {
    Write-Host "PyInstaller 安装成功" -ForegroundColor Green
}
Write-Host ""

Write-Host "[3/3] 使用 PyInstaller 打包项目..." -ForegroundColor Yellow

# 清理旧的构建文件
Write-Host "正在清理旧的构建文件..."
if (Test-Path "build") { Remove-Item -Recurse -Force "build" }
if (Test-Path "dist") { Remove-Item -Recurse -Force "dist" }

Write-Host ""
Write-Host "开始打包..." -ForegroundColor Green

$pyinstallerArgs = @(
    "--onefile",
    "--windowed",
    "--name", "Lean4Generator",
    "--icon", "gui/assets/icon.png",
    "--add-data", "config.py;.",
    "--add-data", "gui/main_window.py;gui",
    "--add-data", "gui/history_manager.py;gui",
    "--add-data", "gui/styles.py;gui",
    "--add-data", "gui/api_history.json;gui",
    "--add-data", "gui/animations.py;gui",
    "--add-data", "gui/assets/icon.png;gui/assets",
    "--add-data", "core/api_client.py;core",
    "--add-data", "core/iterative_validator.py;core",
    "--hidden-import", "PySide6.QtCore",
    "--hidden-import", "PySide6.QtGui",
    "--hidden-import", "PySide6.QtWidgets",
    "--hidden-import", "requests",
    "--noconfirm",
    "app.py"
)

pyinstaller @pyinstallerArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host "错误: 打包失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  打包完成！" -ForegroundColor Green
Write-Host "  可执行文件位置: dist\Lean4Generator.exe" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Inno Setup 是否安装
$innoSetupPath = "C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if (Test-Path $innoSetupPath) {
    Write-Host "[额外] 检测到 Inno Setup，正在创建安装包..." -ForegroundColor Yellow
    & $innoSetupPath "Lean4Generator.iss"

    if ($LASTEXITCODE -ne 0) {
        Write-Host "警告: Inno Setup 编译失败" -ForegroundColor Yellow
    } else {
        Write-Host "安装包已创建！" -ForegroundColor Green
        Write-Host "安装包位置: dist\Lean4Generator-Setup.exe" -ForegroundColor Cyan
    }
} else {
    Write-Host "提示: 如需创建安装包，请安装 Inno Setup 并再次运行" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "按回车键退出"
