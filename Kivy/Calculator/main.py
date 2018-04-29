import kivy
kivy.require('1.10.0')

from kivy.app import App
from kivy.uix.gridlayout import GridLayout

import string


def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    return False

def isint(s):
    try:
        a=float(s)
        b=int(a)
    except ValueError:
        return False
    else:
        return a==b

class CalcGridLayout(GridLayout):

    def calculate(self, calculation):
        if calculation:
            try:
                self.display.text = str(eval(calculation))
            except Exception:
                self.display.text="Error"


    def tobinary(self, number):
        if is_number(number):
            if isint(number):
                num = int(number)
                output = ""
                while num != 0:
                    bit=num%2
                    num = num//2
                    output = str(bit) + output
                self.display.text = output
            else:
                self.display.text="Error"
        else:
            self.display.text="Error"

    def tohex(self, number):
        if is_number(number) and isint(number):
            try:
                output = hex(int(number))
                self.display.text = output[2:]
            except Exception:
                self.display.text = "Error"
        else:
            self.display.text = "Error"






class CalculatorApp(App):

    def build(self):
        return CalcGridLayout()

calcApp = CalculatorApp()
calcApp.run()