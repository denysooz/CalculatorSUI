//
//  ContentView.swift
//  CalculatorSUI
//
//  Created by Denis Dareuskiy on 10.06.24.
//

import SwiftUI

struct CalcView: View {
    
    @StateObject private var viewModel = CalcViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                //text
                VStack {
                    HStack() {
                        Spacer()
                        Text(viewModel.value)
                            .bold()
                            .font(.system(size: 52))
                            .foregroundStyle(.white)
                            .gesture(
                                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                                    .onEnded { value in
                                        if value.translation.width < 0 {
                                            viewModel.deleteLastCharacter()
                                        } else if value.translation.width > 0 {
                                            viewModel.deleteLastCharacter()
                                        }
                                    }
                            )
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                    
                    HStack {
                        Spacer()
                        Text("\(viewModel.formattedCalculatedValue)")
                            .bold()
                            .font(.system(size: 52))
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
                                        width: item.buttonWidth(item: item),
                                        height: item.buttonHeight()
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
}

#Preview {
    CalcView()
}
