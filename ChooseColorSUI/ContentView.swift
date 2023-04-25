//
//  ContentView.swift
//  ChooseColorSUI
//
//  Created by Богдан Радченко on 23.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redTFValue: Double = 0
    @State private var greenTFValue: Double = 0
    @State private var blueTFValue: Double = 0
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)

    @State private var isAlertPresented = false

    @FocusState private var isFocused: Bool
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var body: some View {
        
        VStack(spacing: 40) {
            ColorView(redColor: redSliderValue / 255, greenColor: greenSliderValue / 255, blueColor: blueSliderValue / 255)
            
            HStack(alignment: .center) {
                VStack(spacing: 20) {
                    Text("\(lround(redSliderValue))")
                    Text("\(lround(greenSliderValue))")
                    Text("\(lround(blueSliderValue))")
                }
                .frame(width: 50)
                
                VStack() {
                    Slider(value: $redSliderValue, in: 0...255, step: 1)
                        .tint(.red)
                    Slider(value: $greenSliderValue, in: 0...255, step: 1)
                        .tint(.green)
                    Slider(value: $blueSliderValue, in: 0...255, step: 1)
                        .tint(.blue)
                }
                
                VStack() {
                    
                    ColorTextField(textFieldValue: $redTFValue, sliderValue: $redSliderValue, isAlertPresented: $isAlertPresented, isFocused: _isFocused, formatter: formatter)
                    
                    ColorTextField(textFieldValue: $greenTFValue, sliderValue: $greenSliderValue, isAlertPresented: $isAlertPresented, isFocused: _isFocused, formatter: formatter)
                    
                    ColorTextField(textFieldValue: $blueTFValue, sliderValue: $blueSliderValue, isAlertPresented: $isAlertPresented, isFocused: _isFocused, formatter: formatter)
                    
//                    TextField("0", value: $greenSliderValue, formatter: formatter)
//                        .textFieldStyle(.roundedBorder)
//                        .focused($isFocused)
//                        .keyboardType(.decimalPad)
//
//                    TextField("0", value: $blueSliderValue, formatter: formatter)
//                        .textFieldStyle(.roundedBorder)
//                        .focused($isFocused)
//                        .keyboardType(.decimalPad)
                }
//                .toolbar {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Spacer()
//                        Button("Done") {
//                            checkNumber(from: redSliderValue)
//                        }
//                        .alert("Wrong number", isPresented: $isAlertPresented, actions: { }) {
//                            Text("Enter correct number (0-255)")
//                        }
//                    }
//                }
                .frame(width: 50)
            }
            
            Spacer()
        }

        .padding()
        .background(.purple)
        .onTapGesture {
            isFocused = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorView: View {
    let redColor: Double
    let greenColor: Double
    let blueColor: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350, height: 200)
            .foregroundColor(Color(red: redColor, green: greenColor, blue: blueColor))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 8))
    }
}

struct ColorTextField: View {
    @Binding var textFieldValue: Double
    @Binding var sliderValue: Double
    @Binding var isAlertPresented: Bool
    
    @FocusState var isFocused: Bool
    
    let formatter: Formatter
    
    var body: some View {
        
        TextField("0", value: $textFieldValue, formatter: formatter)
            .textFieldStyle(.roundedBorder)
            .focused($isFocused)
            .keyboardType(.decimalPad)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        checkNumber(from: textFieldValue)
                    }
                    .alert("Wrong number", isPresented: $isAlertPresented, actions: {} ) {
                        Text("Enter correct number")
                    }

                }
            }
            .onAppear {
                textFieldValue = sliderValue
            }
            .onChange(of: sliderValue) { _ in
                textFieldValue = sliderValue
            }
    }
    
    private func checkNumber(from value: Double) {
        if value < 0 || value > 255 {
            isAlertPresented.toggle()
        } else {
            sliderValue = value
            isFocused = false
        }
    }
}
