//
//  BinaryClockWidget.swift
//  BinaryClockWidget
//
//  Created by 김찬우 on 10/3/23.
//

import WidgetKit
import SwiftUI

struct ClockEntry: TimelineEntry {
    var date: Date
}

struct ClockTimelineProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> ClockEntry {
        ClockEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ClockEntry) -> Void) {
        let entry = ClockEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ClockEntry>) -> Void) {
        let currentDate = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)
        
        let entries = [ClockEntry(date: currentDate)]
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate!))
        completion(timeline)
    }
}

struct CircleView: View {
    var isEnabled: Bool
    var size: CGFloat
    
    var body: some View {
        Circle()
            .fill(isEnabled ? Color.white : Color.clear)
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .frame(width: size, height: size)
    }
}

struct BinaryClockWidgetEntryView : View {
    var entry: ClockTimelineProvider.Entry
    let colorData = ColorData()
    
    var body: some View {
        let currentDate = entry.date
        let calender = Calendar.current
        
        let hour: Int = calender.component(.hour, from: currentDate) % 12
        let min: Int = calender.component(.minute, from: currentDate)
        
        GeometryReader { geometry in
            let size = geometry.size.width * 0.1
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Spacer().frame(width: size)
                HStack {
                    CircleView(isEnabled: (hour & 0b1000) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (hour & 0b0100) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (hour & 0b0010) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (hour & 0b0001) > 0, size: size)
                    Spacer().frame(width: 0)
                }.frame(width: geometry.size.width)
                Spacer().frame(height: size)
                HStack {
                    CircleView(isEnabled: (min & 0b100000) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (min & 0b010000) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (min & 0b001000) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (min & 0b000100) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (min & 0b000010) > 0, size: size)
                    Spacer()
                    CircleView(isEnabled: (min & 0b000001) > 0, size: size)
                    Spacer().frame(width: 0)
                }.frame(width: geometry.size.width)
                Spacer().frame(width: size)
            }
        }.containerBackground(for: .widget) {
            colorData.loadColor()
        }
    }
}

struct BinaryClockWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "BinaryClockWidget", 
            provider: ClockTimelineProvider()
        ) { entry in
            BinaryClockWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
