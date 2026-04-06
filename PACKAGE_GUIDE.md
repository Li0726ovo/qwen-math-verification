# Lean4Generator 安装包制作指南

## 方法一: 使用自动化脚本（推荐）

### Windows 用户

1. **双击运行批处理脚本**
   - 右键点击 `build_installer.bat`
   - 选择"以管理员身份运行"
   - 等待打包完成

2. **或使用 PowerShell**
   - 右键点击 `build_installer.ps1`
   - 选择"使用 PowerShell 运行"
   - 如果提示执行策略错误，先运行:
     ```powershell
     Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
     ```

## 方法二: 手动打包

### 步骤 1: 安装 PyInstaller

```bash
pip install pyinstaller
```

### 步骤 2: 使用 PyInstaller 打包

```bash
pyinstaller --onefile --windowed --name Lean4Generator --icon "gui/assets/icon.png" --add-data "config.py;." --add-data "gui/main_window.py;gui" --add-data "gui/history_manager.py;gui" --add-data "gui/styles.py;gui" --add-data "gui/api_history.json;gui" --add-data "gui/animations.py;gui" --add-data "gui/assets/icon.png;gui/assets" --add-data "core/api_client.py;core" --add-data "core/iterative_validator.py;core" --hidden-import PySide6.QtCore --hidden-import PySide6.QtGui --hidden-import PySide6.QtWidgets --hidden-import requests --noconfirm app.py
```

### 步骤 3: 可选 - 创建安装包（需要 Inno Setup）

1. 下载并安装 Inno Setup: https://jrsoftware.org/isdl.php
2. 运行以下命令编译安装包:
   ```bash
   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" Lean4Generator.iss
   ```

## 打包参数说明

- `--onefile`: 打包成单个可执行文件
- `--windowed`: 不显示控制台窗口
- `--name`: 可执行文件名称
- `--icon`: 应用图标
- `--add-data`: 添加数据文件 (源文件;目标目录)
- `--hidden-import`: 隐式导入的模块
- `--noconfirm`: 覆盖旧文件不询问

## 输出文件

- **单文件版**: `dist/Lean4Generator.exe`
- **安装包版**: `dist/Lean4Generator-Setup.exe`（需要 Inno Setup）

## 常见问题

### 问题 1: PyInstaller 未安装
**解决**: 运行 `pip install pyinstaller`

### 问题 2: 缺少依赖
**解决**: 运行 `pip install -r requirements.txt`

### 问题 3: 图标不显示
**解决**: 确保 `gui/assets/icon.png` 文件存在

### 问题 4: 打包后程序无法启动
**解决**: 检查控制台输出,可能需要添加更多 `--hidden-import` 参数

## 分发说明

打包后的 `Lean4Generator.exe` 可以独立运行，无需用户安装 Python 和依赖项。
