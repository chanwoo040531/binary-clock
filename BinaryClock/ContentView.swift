//
//  ContentView.swift
//  BinaryClock
//
//  Created by 김찬우 on 10/3/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var backgroundColor: Color = Color.black
    @State private var bitColor: Color = Color.white
    private var colorData = ColorData()
    
    var body: some View {
        VStack(spacing: 10) {
            ColorPicker("Pick a background color: ", selection: $backgroundColor, supportsOpacity: false)
            ColorPicker("Pick a bit color", selection: $bitColor, supportsOpacity: false)
            
            Button("save") {
                colorData.saveColor(color: backgroundColor, option: .background)
                colorData.saveColor(color: bitColor, option: .bit)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            backgroundColor = colorData.loadColor(option: .background)
            bitColor = colorData.loadColor(option: .bit)
        }
    }
}

#Preview {
    ContentView()
}
