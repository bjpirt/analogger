//
//  AnaloggerWidgetControl.swift
//  AnaloggerWidget
//
//  Created by Ben Pirt on 24/09/2024.
//

import AppIntents
import SwiftUI
import WidgetKit

struct AnaloggerWidgetControl: ControlWidget {
    static let kind: String = "com.pirt.analogger.Analogger.AnaloggerControlWidget"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: Self.kind
        ) {
            ControlWidgetButton(action: LogShotIntent()) {
                Label("Log Shot", systemImage: "camera.aperture")
            }
        }
        .displayName("Log Shot")
        .description("Log a shot in Analogger")
    }
}
