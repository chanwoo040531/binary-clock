//
//  ContentView.swift
//  BinaryClock
//
//  Created by 김찬우 on 10/3/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var color: Color = Color.black
    private var colorData = ColorData()
    
    var body: some View {
        VStack(spacing: 10) {
            ColorPicker("Pick a color: ", selection: $color, supportsOpacity: false)
            
            Button("save") {
                colorData.saveColor(color: color)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            color = colorData.loadColor()
        }
    }
}

#Preview {
    ContentView()
}
