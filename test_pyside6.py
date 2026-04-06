import sys
from PySide6.QtWidgets import QApplication, QMainWindow, QLabel
from PySide6.QtCore import Qt

def main():
    app = QApplication(sys.argv)
    window = QMainWindow()
    window.setWindowTitle("PySide6 Test")
    window.setGeometry(100, 100, 300, 200)
    
    label = QLabel("PySide6 is working!")
    label.setAlignment(Qt.AlignCenter)
    window.setCentralWidget(label)
    
    window.show()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()