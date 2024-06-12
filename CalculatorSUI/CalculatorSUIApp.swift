//
//  CalculatorSUIApp.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 10.06.24.
//

import SwiftUI

@main
struct CalculatorSUIApp: App {
    @StateObject private var calcViewModel = CalcViewModel()
    
    var body: some Scene {
        WindowGroup {
            CalcView(viewModel: calcViewModel)
        }
    }
}
