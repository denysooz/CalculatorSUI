//
//  ContentView.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 10.06.24.
//

import SwiftUI

struct CalcView: View {
    
    @StateObject var viewModel: CalcViewModel
    
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
                        Text(viewModel.value)
                            .bold()
                            .font(.system(size: 64))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                    
                    HStack {
                        Spacer()
                        Text("\(viewModel.calculatedValue)")
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
                                viewModel.didTap(button: item)
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
    
    
    
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        return item == .equal ? (UIScreen.main.bounds.width - (4*6))/4 * 2 : (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

#Preview {
    CalcView(viewModel: CalcViewModel())
}
