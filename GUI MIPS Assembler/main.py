from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.uic import loadUiType
import sys
from os import path
import os
from PyQt5.QtWidgets import QApplication, QMainWindow, QMenu, QVBoxLayout, QSizePolicy, QMessageBox, QWidget, \
    QPushButton
from PyQt5.QtGui import QIcon
from Assembler import *


FORM_CLASS,_ = loadUiType(path.join(path.dirname(__file__), "main.ui"))



class MainApp(QMainWindow, FORM_CLASS):



    def __init__(self, parent= None):
        super(MainApp, self).__init__(parent)
        QMainWindow.__init__(self)
        self.setupUi(self)
        self.setup_Ui()
        self.init_Buttons()





    def setup_Ui(self):
        self.setWindowTitle("MIPS Assembler")
        self.setFixedSize(900,600)
        #self.setStyleSheet("background-color: rgb()")
        #self.textEdit.setStyleSheet("background-color: white")





    def init_Buttons(self):
        self.browse_button.clicked.connect(self.openFile)
        self.assemble_button.clicked.connect(self.assemble_code)

    def openFile(self):
        options = QFileDialog.Options()
        options |= QFileDialog.DontUseNativeDialog

        self.fileName, _ = QFileDialog.getOpenFileName(self, "Open file to simulate", "", "Verilog Files (*.v)", options=options)
        if self.fileName:
            self.file_path.setText(self.fileName)
        self.run_command = "'" + self.fileName[0:-7] + "'"
        self.compile_command = "iverilog '" + self.fileName + "' -o " + self.run_command


    def assemble_code(self):
        self.assembler = Assembler(self.textEdit.toPlainText())
        self.run_code()




    def run_code(self):
        os.system(self.compile_command)
        os.system(self.run_command)








def main():
    app = QApplication(sys.argv)
    window = MainApp()
    window.show()
    app.exec_()

if __name__ == '__main__':
    main()
