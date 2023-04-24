//
//  ContentView.swift
//  ChooseColorSUI
//
//  Created by Богдан Радченко on 23.04.2023.
//

import SwiftUI

struct ContentView: View {
    enum Field {
        case red
        case green
        case blue
    }
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @FocusState private var focusedField: Field?
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
            
            HStack(alignment: .center,spacing: 23) {
                VStack(spacing: 20) {
                    Text("\(lround(redSliderValue))")
                    Text("\(lround(greenSliderValue))")
                    Text("\(lround(blueSliderValue))")
                }
                .frame(width: 40)
                
                VStack() {
                    Slider(value: $redSliderValue, in: 0...255, step: 1)
                        .tint(.red)
                    Slider(value: $greenSliderValue, in: 0...255, step: 1)
                        .tint(.green)
                    Slider(value: $blueSliderValue, in: 0...255, step: 1)
                        .tint(.blue)
                }
                
                VStack(spacing: 20) {
                    TextField("Number", value: $redSliderValue, formatter: formatter)
                        .focused($focusedField, equals: .red)
                        .keyboardType(.decimalPad)
                    TextField("0", value: $greenSliderValue, formatter: formatter)
                        .focused($focusedField, equals: .green)
                        .keyboardType(.decimalPad)
                    TextField("0", value: $blueSliderValue, formatter: formatter)
                        .focused($focusedField, equals: .blue)
                        .keyboardType(.decimalPad)
                }
                .frame(width: 50)
            }
            
            Spacer()
        }

        .padding()
        .background(.purple)
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
    }
}
