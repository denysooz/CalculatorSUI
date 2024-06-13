//
//  CalcViewModel.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 11.06.24.
//

import Foundation
import SwiftUI

class CalcViewModel: ObservableObject {
    
    var characterLimit: Int
    init(limit: Int = 9){
        characterLimit = limit
    }
    @Published var value = "0" {
        didSet {
            if value.count > characterLimit {
                value = String(value.prefix(characterLimit))
            }
        }
    }
    var calculatedValue: Double = 0 {
        didSet {
            formattedCalculatedValue = formatResult(calculatedValue)
        }
    }
    @Published var formattedCalculatedValue: String = "0"
    var runningNumber = 0
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            if currentOperation == .none {
                if value == "0" {
                    firstNumber = calculatedValue
                } else {
                    firstNumber = Double(value) ?? 0
                }
                value = "0"
            } else {
                secondNumber = Double(value) ?? 0
                calculateResult()
                firstNumber = calculatedValue
                value = "0"
            }
            
            if button == .add {
                currentOperation = .add
            } else if button == .subtract {
                currentOperation = .subtract
            } else if button == .multiply {
                currentOperation = .multiply
            } else if button == .divide {
                currentOperation = .divide
            }
            
        case .equal:
            secondNumber = Double(value) ?? 0
            calculateResult()
            currentOperation = .none
            value = "0"
            
        case .clear:
            value = "0"
            calculatedValue = 0
            firstNumber = 0
            secondNumber = 0
            currentOperation = .none
            
        case .negative:
            // Обработка кейса .negative
            if value == "0" {
                calculatedValue = -calculatedValue
                formattedCalculatedValue = formatResult(calculatedValue)
            } else {
                var currentValue = Double(value) ?? 0.0
                currentValue = -currentValue
                value = String(currentValue)
            }
            
        case .percent:
                // Обработка кейса .percent
                if value == "0" {
                    calculatedValue /= 100
                    formattedCalculatedValue = formatResult(calculatedValue)
                } else {
                    var currentValue = Double(value) ?? 0.0
                    currentValue /= 100
                    value = String(currentValue)
                }
            
        default:
            if value == "0" {
                value = button.rawValue
            } else {
                value = "\(value)\(button.rawValue)"
            }
        }
    }
    
    func calculateResult() {
        switch currentOperation {
        case .add:
            calculatedValue = firstNumber + secondNumber
        case .subtract:
            calculatedValue = firstNumber - secondNumber
        case .multiply:
            calculatedValue = firstNumber * secondNumber
        case .divide:
            if secondNumber == 0 {
                calculatedValue = 0
            } else {
                calculatedValue = firstNumber / secondNumber
            }
        case .none:
            break
        }
    }
    
    func formatResult(_ result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 7
        formatter.minimumFractionDigits = 0
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 7
        
        // Проверяем, равен ли результат 0
        if result == 0 {
            return "0"
        }
        
        // Форматируем результат в научной нотации, если число очень большое или очень маленькое
        if abs(result) >= 1e+9 || abs(result) < 1e-6 {
            formatter.numberStyle = .scientific
            return formatter.string(from: NSNumber(value: result)) ?? "0"
        } else {
            // Если нет, возвращаем строку с форматированным дробным числом
            return formatter.string(from: NSNumber(value: result)) ?? "0"
        }
    }
    
    func deleteLastCharacter() {
        if !value.isEmpty {
            value.removeLast()
            if value.isEmpty {
                value = "0"
            }
        }
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
}
