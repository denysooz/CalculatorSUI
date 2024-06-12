//
//  Operation.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 11.06.24.
//

import Foundation

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case none = ""
    
    func toString() -> String {
        return self.rawValue
    }
}
