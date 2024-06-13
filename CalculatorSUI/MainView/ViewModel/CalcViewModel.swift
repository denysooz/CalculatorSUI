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
    init(limit: Int = 12){
        characterLimit = limit
    }
    @Published var value = "0" {
        didSet {
            if value.count > 10 {
                value = String(value.prefix(10))
            }
        }
    }
    @Published var calculatedValue = 0
    var runningNumber = 0
    var firstNumber: Int = 0
    var secondNumber: Int = 0
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
                    firstNumber = Int(value) ?? 0
                }
                value = "0"
            } else {
                secondNumber = Int(value) ?? 0
                calculateResult()
                firstNumber = secondNumber
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
            secondNumber = Int(value) ?? 0
            calculateResult()
            currentOperation = .none
            value = "0"
            
        case .clear:
            value = "0"
            calculatedValue = 0
            firstNumber = 0
            secondNumber = 0
            currentOperation = .none
            
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
            calculatedValue = firstNumber / secondNumber
        case .none:
            break
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

