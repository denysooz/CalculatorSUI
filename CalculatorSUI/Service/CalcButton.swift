//
//  CalcButtons.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 11.06.24.
//

import Foundation
import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case clear = "C"
    case negative = "+/-"
    case divide = "÷"
    case multiply = "×"
    case subtract = "-"
    case add = "+"
    case equal = "="
    case decimal = "."
    case percent = "%"
    
    var buttonBackgroundColor: Color {
        switch self {
        case .clear:
            return .pink
        case .equal:
            return .green
        default:
            return .gray.opacity(0.4)
        }
    }
    
    var buttonTextColor: Color {
        switch self {
        case .clear, .equal:
            return .black
        case .percent, .divide, .multiply, .add, .subtract:
            return .green
        default:
            return .white
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        return item == .equal ? (UIScreen.main.bounds.width - (4*6))/4 * 2 : (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}
