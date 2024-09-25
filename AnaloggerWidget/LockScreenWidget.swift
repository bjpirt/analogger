//
//  LockScreenWidget.swift
//  Analogger
//
//  Created by Ben Pirt on 25/09/2024.
//


import SwiftUI
import WidgetKit

struct LockScreenWidget: Widget {
    private let kind: String = WidgetType.lockScreen.kind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) {
            EntryView(entry: $0)
        }
        .configurationDisplayName("Lock Screen Widget")
        .description("Display the Widget on both the lock screen and the home screen.")
        .supportedFamilies([.accessoryCircular, .accessoryInline, .accessoryRectangular, .systemSmall])
    }
}
