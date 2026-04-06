import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication, QMessageBox
from PySide6.QtGui import QIcon
from gui.main_window import LeanGeneratorWindow
from gui.styles import STYLESHEET

def main():
    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    app.setStyleSheet(STYLESHEET)
    app.setApplicationName("数学证明的Lean语言交互式转译器")
    
    # 优化：设置应用程序属性以提升性能
    app.setAttribute(0)  # Qt.AA_UseHighDpiPixmaps
    app.setAttribute(1)  # Qt.AA_EnableHighDpiScaling
    
    try:
        icon_path = Path(__file__).parent / "gui" / "assets" / "icon.png"
        if icon_path.exists():
            app.setWindowIcon(QIcon(str(icon_path)))
    except Exception:
        pass

    try:
        window = LeanGeneratorWindow()
        window.setMinimumSize(1000, 750)  # 优化：增加最小窗口尺寸以适应新UI
        window.show()
    except Exception as e:
        QMessageBox.critical(None, "初始化失败", f"错误: {str(e)}")
        return 1

    sys.exit(app.exec())

if __name__ == "__main__":
    sys.path.append(str(Path(__file__).parent))
    main()