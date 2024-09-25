//
//  AnaloggerWidgetBundle.swift
//  AnaloggerWidget
//
//  Created by Ben Pirt on 24/09/2024.
//

import WidgetKit
import SwiftUI

@main
struct AnaloggerWidgetBundle: WidgetBundle {
    var body: some Widget {
        AnaloggerWidget()
        AnaloggerWidgetControl()
        AnaloggerWidgetLiveActivity()
    }
}
