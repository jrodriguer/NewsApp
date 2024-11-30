//
//  NewsAppIOSWidgetLiveActivity.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 30/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct NewsAppIOSWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsAppIOSWidgetAttributes.self) { context in
            
            VStack(alignment: .leading, spacing: 8) {
                Text(context.state.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(context.state.source)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let timeSince = context.state.timeSincePublished {
                    Text(timeSince)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .padding(.horizontal, 16)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(context.state.title)
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text(context.state.source)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let timeSince = context.state.timeSincePublished {
                        Text(timeSince)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if let timeSince = context.state.timeSincePublished {
                        Text("\(timeSince) time ago")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            } compactLeading: {
                Image(systemName: "newspaper.fill")
                        .font(.body)
                        .foregroundColor(.accentColor)
            } compactTrailing: {
                Text(context.state.source)
                        .font(.caption)
                        .lineLimit(1)
            } minimal: {
                Text("\(context.state.source.prefix(1))")
                    .font(.body)
                    .foregroundColor(.accentColor)
            }
            .keylineTint(.accentColor)
        }
    }
}

extension NewsAppIOSWidgetAttributes {
    fileprivate static let preview: NewsAppIOSWidgetAttributes = NewsAppIOSWidgetAttributes(id: "1")
}

extension NewsAppIOSWidgetAttributes.ContentState {
    fileprivate static let activityState = NewsAppIOSWidgetAttributes.ContentState(
        source: "The Washington Post",
        author: "Hannah Docter-Loeb",
        title: "Americans see disparities in mental and physical care, survey finds - The Washington Post",
        publishedAt: "2024-11-01T12:30:00Z"
    )
}

#Preview("Notification", as: .content, using: NewsAppIOSWidgetAttributes.preview) {
    NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.activityState
}

#Preview("Dynamic Island Expanded", as: .dynamicIsland(.expanded), using: NewsAppIOSWidgetAttributes.preview) {
    NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.activityState
}

#Preview("Dynamic Island Compact", as: .dynamicIsland(.compact), using: NewsAppIOSWidgetAttributes.preview) {
    NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.activityState
}
