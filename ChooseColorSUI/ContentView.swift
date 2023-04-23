//
//  ContentView.swift
//  ChooseColorSUI
//
//  Created by Богдан Радченко on 23.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height: 200)
                .foregroundColor(Color(red: redSliderValue, green: greenSliderValue, blue: blueSliderValue))
            
            HStack(alignment: .center,spacing: 20) {
                VStack(spacing: 20) {
                    Text("\(redSliderValue)")
                    Text("\(greenSliderValue)")
                    Text("\(blueSliderValue)")
                }
                
                VStack() {
                    Slider(value: $redSliderValue, in: 0...255, step: 1)
                    Slider(value: $greenSliderValue, in: 0...255, step: 1)
                    Slider(value: $blueSliderValue, in: 0...255, step: 1)
                }
                
                VStack(spacing: 20) {
                    TextField("0", text: .constant(""))
                    TextField("0", text: .constant(""))
                    TextField("0", text: .constant(""))
                }
            }
            
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
