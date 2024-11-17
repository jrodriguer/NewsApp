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
                    
                    Text("\(context.state.publishedRange.lowerBound.formatted(.dateTime))")
                        .font(.caption)
                        .foregroundColor(.secondary)
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
                    Text("Published: \(context.state.publishedRange.lowerBound.formatted(.dateTime))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                DynamicIslandExpandedRegion(.center) {
                    // TODO: Desingn center of Dinamyc Island.
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Published: \(context.state.publishedRange.lowerBound.formatted(.dateTime)) - \(context.state.publishedRange.upperBound.formatted(.dateTime))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            } compactLeading: {
                // TODO: Newspaper user alias (add to feature project).
                Image(systemName: "newspaper.fill")
                        .font(.body)
                        .foregroundColor(.accentColor)
            } compactTrailing: {
                // TODO: Symbol by article genre.
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
        publishedRange: Date()...Date().addingTimeInterval(15 * 60)
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
