//
//  AnaloggerWidget.swift
//  AnaloggerWidget
//
//  Created by Ben Pirt on 24/09/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let analoggerActions: AnaloggerActions = .shared

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), filmRollName: "Film roll name", shotCount: 14)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), filmRollName: "Film roll name", shotCount: 13)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let filmRoll = analoggerActions.getActiveFilmRoll()

        let entries = [SimpleEntry(date: Date(), filmRollName: filmRoll?.name ?? "No film rolls found", shotCount: filmRoll?.filmShots?.count ?? 0)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let filmRollName: String
    let shotCount: Int
}

struct AnaloggerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("\(entry.shotCount) shots")
                .bold()
            Spacer()
            Button(intent: LogShotIntent()){
                Text("Log a shot")
            }
            Spacer()
            Text(entry.filmRollName)
                .font(.subheadline)
        }
    }
}

struct AnaloggerWidget: Widget {
    let kind: String = "com.pirt.analogger.Analogger.AnaloggerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AnaloggerWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    AnaloggerWidget()
} timeline: {
    SimpleEntry(date: .now, filmRollName: "Film Roll Name", shotCount: 10)
    SimpleEntry(date: .now, filmRollName: "Film Roll Name", shotCount: 11)
}
