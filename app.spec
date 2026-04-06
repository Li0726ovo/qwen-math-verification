# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

# 使用 os.getcwd() 替代 __file__
import os
import sys
current_dir = os.getcwd()
sys.path.append(current_dir)

a = Analysis(
    ['app.py'],
    pathex=[current_dir],
    binaries=[],
    datas=[
        # 配置文件
        ('config.py', '.'),
        
        # GUI模块和资源
        ('gui/main_window.py', 'gui'),
        ('gui/history_manager.py', 'gui'),
        ('gui/styles.py', 'gui'),
        ('gui/api_history.json', 'gui'),
        
        # 核心模块
        ('core/api_client.py', 'core'),
        ('core/iterative_validator.py', 'core'),
        
        # 图标资源
        ('gui/assets/icon.png', 'gui/assets'),
    ],
    hiddenimports=[
        # PySide6组件（只包含必要的）
        'PySide6.QtCore',
        'PySide6.QtGui',
        'PySide6.QtWidgets',
        
        # 第三方库
        'requests',
        
        # 项目模块
        'gui.main_window',
        'gui.history_manager',
        'gui.styles',
        'core.api_client',
        'core.iterative_validator',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[
        # 排除不必要的模块以减少打包大小
        'tkinter',
        'unittest',
        'pydoc',
        'doctest',
        'optparse',
        'getopt',
        'zipfile',
        'tarfile',
        'gzip',
        'bz2',
        'lzma',
        'cryptography',
        'sqlite3',
        'psutil',
        'numpy',
        'scipy',
        'matplotlib',
        'pandas',
    ],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='Lean4Generator',
    debug=False,
    bootloader_ignore_signals=False,
    strip=True,  # 启用符号剥离以减少大小
    upx=True,    # 启用UPX压缩
    upx_exclude=[
        # 排除某些模块以避免UPX压缩问题
        'vcruntime140.dll',
        'msvcp140.dll',
    ],
    runtime_tmpdir=None,
    console=False,
    icon=os.path.join('gui', 'assets', 'icon.png') if os.path.exists(os.path.join('gui', 'assets', 'icon.png')) else None,
)