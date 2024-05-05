//
//  NewsMacWidgetLiveActivity.swift
//  NewsMacWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NewsMacWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct NewsMacWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsMacWidgetAttributes.self) { context in
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

extension NewsMacWidgetAttributes {
    fileprivate static var preview: NewsMacWidgetAttributes {
        NewsMacWidgetAttributes(name: "World")
    }
}

extension NewsMacWidgetAttributes.ContentState {
    fileprivate static var smiley: NewsMacWidgetAttributes.ContentState {
        NewsMacWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: NewsMacWidgetAttributes.ContentState {
         NewsMacWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: NewsMacWidgetAttributes.preview) {
   NewsMacWidgetLiveActivity()
} contentStates: {
    NewsMacWidgetAttributes.ContentState.smiley
    NewsMacWidgetAttributes.ContentState.starEyes
}
