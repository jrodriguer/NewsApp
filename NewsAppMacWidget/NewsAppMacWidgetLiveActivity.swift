//
//  NewsAppMacWidgetLiveActivity.swift
//  NewsAppMacWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NewsAppMacWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct NewsAppMacWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsAppMacWidgetAttributes.self) { context in
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

extension NewsAppMacWidgetAttributes {
    fileprivate static var preview: NewsAppMacWidgetAttributes {
        NewsAppMacWidgetAttributes(name: "World")
    }
}

extension NewsAppMacWidgetAttributes.ContentState {
    fileprivate static var smiley: NewsAppMacWidgetAttributes.ContentState {
        NewsAppMacWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: NewsAppMacWidgetAttributes.ContentState {
         NewsAppMacWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: NewsAppMacWidgetAttributes.preview) {
   NewsAppMacWidgetLiveActivity()
} contentStates: {
    NewsAppMacWidgetAttributes.ContentState.smiley
    NewsAppMacWidgetAttributes.ContentState.starEyes
}
