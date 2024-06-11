//
//  CalcViewModel.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 11.06.24.
//

import Foundation

class CalcViewModel: ObservableObject {
    
   
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
}
