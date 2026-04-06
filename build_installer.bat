@echo off
echo ================================================
echo Lean4Generator 安装包构建脚本
echo ================================================
echo.

echo [1/3] 检查 Python 环境...
python --version
if %errorlevel% neq 0 (
    echo 错误: 未找到 Python
    pause
    exit /b 1
)
echo.

echo [2/3] 安装 PyInstaller...
pip install pyinstaller
if %errorlevel% neq 0 (
    echo 警告: PyInstaller 安装失败，可能已安装
)
echo.

echo [3/3] 使用 PyInstaller 打包项目...
echo 正在清理旧的构建文件...
if exist build rmdir /s /q build
if exist dist\* rmdir /s /q dist

echo.
echo 开始打包...
pyinstaller --onefile --windowed --name Lean4Generator --icon "gui/assets/icon.png" --add-data "config.py;." --add-data "gui/main_window.py;gui" --add-data "gui/history_manager.py;gui" --add-data "gui/styles.py;gui" --add-data "gui/api_history.json;gui" --add-data "gui/animations.py;gui" --add-data "gui/assets/icon.png;gui/assets" --add-data "core/api_client.py;core" --add-data "core/iterative_validator.py;core" --hidden-import PySide6.QtCore --hidden-import PySide6.QtGui --hidden-import PySide6.QtWidgets --hidden-import requests --noconfirm app.py

if %errorlevel% neq 0 (
    echo 错误: 打包失败
    pause
    exit /b 1
)

echo.
echo ================================================
echo 打包完成！
echo 可执行文件位置: dist\Lean4Generator.exe
echo ================================================
echo.

if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    echo [额外] 检测到 Inno Setup，正在创建安装包...
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" Lean4Generator.iss
    if %errorlevel% neq 0 (
        echo 警告: Inno Setup 编译失败
    ) else (
        echo 安装包已创建！
    )
) else (
    echo 提示: 如需创建安装包，请安装 Inno Setup 并再次运行
)

pause
