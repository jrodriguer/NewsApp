//
//  NewsAppIOSWidgetLiveActivity.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 30/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NewsAppIOSWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct NewsAppIOSWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsAppIOSWidgetAttributes.self) { context in
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

extension NewsAppIOSWidgetAttributes {
    fileprivate static var preview: NewsAppIOSWidgetAttributes {
        NewsAppIOSWidgetAttributes(name: "World")
    }
}

extension NewsAppIOSWidgetAttributes.ContentState {
    fileprivate static var smiley: NewsAppIOSWidgetAttributes.ContentState {
        NewsAppIOSWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: NewsAppIOSWidgetAttributes.ContentState {
         NewsAppIOSWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: NewsAppIOSWidgetAttributes.preview) {
   NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.smiley
    NewsAppIOSWidgetAttributes.ContentState.starEyes
}
