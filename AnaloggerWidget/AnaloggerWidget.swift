//
//  AnaloggerWidget.swift
//  AnaloggerWidget
//
//  Created by Ben Pirt on 24/09/2024.
//

import WidgetKit
import SwiftUI


extension AnaloggerWidget {
    struct Provider: TimelineProvider {
        let analoggerActions: AnaloggerActions = .shared

        func placeholder(in context: Context) -> Entry {
            Entry(date: Date(), filmRollName: "Film roll name", shotCount: 14)
        }

        func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
            let entry = Entry(date: Date(), filmRollName: "Film roll name", shotCount: 13)
            completion(entry)
        }

        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            let filmRoll = analoggerActions.getActiveFilmRoll()

            let entries = [Entry(date: Date(), filmRollName: filmRoll?.name ?? "No film rolls found", shotCount: filmRoll?.filmShots?.count ?? 0)]

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

extension AnaloggerWidget {
    struct Entry: TimelineEntry {
        let date: Date
        let filmRollName: String
        let shotCount: Int
    }
}

extension AnaloggerWidget {
    struct EntryView: View {
        @Environment(\.widgetFamily) var widgetFamily

        let entry: Entry

        var body: some View {
            VStack(alignment: .leading) {
                contentView
            }
            .containerBackground(.clear, for: .widget)
        }
    }
}

extension AnaloggerWidget.EntryView {
    @ViewBuilder
    private var contentView: some View {
        if widgetFamily == .accessoryRectangular {
            accessoryRectangularView
        } else if widgetFamily == .accessoryCircular {
            accessoryCircularView
        } else {
            defaultView
        }
    }

    private var accessoryRectangularView: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.black)
                    Text(String(entry.shotCount))
                        .bold()
                }
                Spacer()
                Button(intent: LogShotIntent()){
                    Text("Log a shot")
                }
            }
            Text(entry.filmRollName)
                .font(.subheadline)
        }
    }

    private var accessoryCircularView: some View {
        Button(intent: LogShotIntent()){
            VStack {
                Image(systemName: "camera.aperture").scaledToFill()
                Text(String(entry.shotCount)).fontWeight(.bold)
                    .foregroundStyle(.white)
            }.padding([.all], 10)
        }.buttonBorderShape(.circle)
        .padding([.all], -10)
    }

    private var defaultView: some View {
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
            EntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .systemSmall])
    }
}

#Preview(as: .systemSmall) {
    AnaloggerWidget()
} timeline: {
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 20)
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 11)
}
#Preview(as: .accessoryRectangular) {
    AnaloggerWidget()
} timeline: {
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 20)
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 11)
}
#Preview(as: .accessoryCircular) {
    AnaloggerWidget()
} timeline: {
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 20)
    AnaloggerWidget.Entry(date: .now, filmRollName: "Film Roll Name", shotCount: 11)
}
