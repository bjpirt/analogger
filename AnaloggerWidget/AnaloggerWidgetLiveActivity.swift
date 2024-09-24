//
//  AnaloggerWidgetLiveActivity.swift
//  AnaloggerWidget
//
//  Created by Ben Pirt on 24/09/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct AnaloggerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct AnaloggerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AnaloggerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension AnaloggerWidgetAttributes {
    fileprivate static var preview: AnaloggerWidgetAttributes {
        AnaloggerWidgetAttributes(name: "World")
    }
}

extension AnaloggerWidgetAttributes.ContentState {
    fileprivate static var smiley: AnaloggerWidgetAttributes.ContentState {
        AnaloggerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: AnaloggerWidgetAttributes.ContentState {
         AnaloggerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: AnaloggerWidgetAttributes.preview) {
   AnaloggerWidgetLiveActivity()
} contentStates: {
    AnaloggerWidgetAttributes.ContentState.smiley
    AnaloggerWidgetAttributes.ContentState.starEyes
}
