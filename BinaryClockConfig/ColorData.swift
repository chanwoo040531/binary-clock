
import SwiftUI

struct ColorData {
    private var COLOR_KEY = "COLOR_KEY"
    private let userDefaults = UserDefaults(suiteName: "group.me.chnu.BinaryClock")!
    
    func saveColor(color: Color, option: ColorOption) {

        let color = NSColor(color).cgColor
        if let components = color.components {
            userDefaults.set(components, forKey: option.value())
        }
    }
    
    func loadColor(option: ColorOption) -> Color {
        guard let array = userDefaults.object(forKey: option.value()) as? [CGFloat] else { return Color.black }
            let color = Color(.sRGB,
                              red: array[0],
                              green: array[1],
                              blue: array[2],
                              opacity: array[3])
            
            
        return color
    }
}


