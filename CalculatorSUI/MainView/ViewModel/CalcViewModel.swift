//
//  CalcViewModel.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 11.06.24.
//

import Foundation
import SwiftUI

class CalcViewModel: ObservableObject {
    
    @Published var characterLimit: Int
    init(limit: Int = 12){
        characterLimit = limit
    }
    @Published var value = "0" {
        didSet {
            if value.count > 10 {
                value = String(value.prefix(10))
            }
            editingChanged(value)
        }
    }
    @Published var calculatedValue: String = "0"
    @Published var tappedNumber: Int = 0
    @Published var currentOperation: Operation = .none
    @Published var previousOperation: Operation = .none
    @Published var firstNumber: Double = 0
    @Published var secondNumber: Double = 0
    
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
            handleOperatorTap(button)
        case .equal:
            calculateResult()
            currentOperation = .none
            firstNumber = 0
            secondNumber = 0
        case .clear:
            value = "0"
            calculatedValue = "0"
            currentOperation = .none
            firstNumber = 0
            secondNumber = 0
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .negative:
            if let number = Double(value) {
                value = String(number * -1)
            }
        case .percent:
            if let number = Double(value) {
                value = String(number / 100)
            }
        default:
            if value == "0" {
                value = button.rawValue
            } else {
                value += button.rawValue
            }
            tappedNumber = Int(button.rawValue) ?? 0
            if currentOperation == .none {
                calculatedValue = value
            }
        }
    }
    
    private func handleOperatorTap(_ button: CalcButton) {
        if currentOperation == .none {
            currentOperation = operationForButton(button)
            firstNumber = Double(value) ?? 0
            secondNumber = 0
            value += currentOperation.toString()
        } else {
            calculateResult()
            currentOperation = operationForButton(button)
            firstNumber = calculatedValue.doubleValue
            secondNumber = 0
            value = String(firstNumber) + currentOperation.toString()
        }
    }
    
    private func calculateResult() {
        switch currentOperation {
        case .add:
            calculatedValue = formatResult(Decimal(firstNumber + (Double(value.components(separatedBy: currentOperation.toString()).last ?? "0") ?? 0)))
            value = calculatedValue
        case .subtract:
            calculatedValue = formatResult(Decimal(firstNumber - (Double(value.components(separatedBy: currentOperation.toString()).last ?? "0") ?? 0)))
            value = calculatedValue
        case .multiply:
            calculatedValue = formatResult(Decimal(firstNumber * (Double(value.components(separatedBy: currentOperation.toString()).last ?? "0") ?? 0)))
            value = calculatedValue
        case .divide:
            let secondNumberString = value.components(separatedBy: currentOperation.toString()).last ?? "0"
            secondNumber = Double(secondNumberString) ?? 0
            if secondNumber == 0 {
                value = "Error"
                calculatedValue = "0"
            } else {
                calculatedValue = formatResult(Decimal(firstNumber / secondNumber))
                value = calculatedValue
            }
        case .none:
            break
        }
    }
    
    private func formatResult(_ value: Decimal) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_US") // or Locale.current

        let formattedValue = numberFormatter.string(from: value as NSNumber) ?? "Error"
        return formattedValue
    }

    private func operationForButton(_ button: CalcButton) -> Operation {
        switch button {
        case .add:
            return .add
        case .subtract:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
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
    
    func updateCalculatedValue(_ newValue: String) {
        calculatedValue = newValue
    }
    
    func editingChanged(_ value: String) {
        if value.isEmpty {
            self.calculatedValue = "0"
        } else {
            self.calculatedValue = value
        }
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
}

