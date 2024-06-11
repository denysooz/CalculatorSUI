//
//  ContentView.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 10.06.24.
//

import SwiftUI

struct CalcView: View {
    
    @State var value = "1+2"
    @State var calculatedValue = 0
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    var viewModel = CalcViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                //text
                VStack {
                    HStack {
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 64))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                    
                    HStack {
                        Spacer()
                        Text("\(calculatedValue)")
                            .bold()
                            .font(.system(size: 64))
                            .foregroundStyle(.gray)
                    }
                    .padding(.trailing)
                }
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    .padding(.bottom)
                //buttons
                ForEach(viewModel.buttons, id: \.self) { row in
                    HStack(spacing: 18) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                didTap(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: buttonHeight()
                                    )
                                    .background(item.buttonBackgroundColor)
                                    .foregroundStyle(item.buttonTextColor)
                                    .cornerRadius(8)
                                    
                            }
                        }
                    }
                    .padding(.bottom, 9)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
                self.value += "+"
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
                self.value += "-"
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
                self.value += "*"
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
                self.value += "/"
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(currentValue)+\(runningValue)"
                    self.calculatedValue = runningValue + currentValue
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
        case .clear:
            self.value = "0"
            self.calculatedValue = 0
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
                self.calculatedValue = Int(number) ?? 0
            } else {
                self.value = "\(self.value)\(number)"
                if currentOperation != .none {
                    if currentOperation == .add {
                        self.calculatedValue += (Int(number) ?? 0)
                    } else if currentOperation == .subtract {
                        self.calculatedValue -= (Int(number) ?? 0)
                    } else if currentOperation == .multiply {
                        self.calculatedValue *= (Int(number) ?? 0)
                    } else if currentOperation == .divide {
                        if number == "0" {
                            self.value = "Error"
                            self.calculatedValue = 0
                        } else {
                            self.calculatedValue /= (Int(number) ?? 0)
                        }
                    }
                }
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        return item == .equal ? (UIScreen.main.bounds.width - (4*6))/4 * 2 : (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

#Preview {
    CalcView()
}
