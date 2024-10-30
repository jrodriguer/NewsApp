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
    public typealias NewsAppIOSWidgetStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var source: String
        var author: String
        var title: String
        var publishedRange: ClosedRange<Date> // Period of time in which the articles were published
    }
    
    var articleCount: Int
}

struct NewsAppIOSWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NewsAppIOSWidgetAttributes.self) { context in
            VStack(alignment: .leading) {
                Text("Source: \(context.state.source)")
                    .font(.headline)
                Text("Author: \(context.state.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Title: \(context.state.title)")
                    .font(.body)
                    .bold()
                Text("Published between:")
                    .font(.footnote)
                Text("\(context.state.publishedRange.lowerBound.formatted(.dateTime)) - \(context.state.publishedRange.upperBound.formatted(.dateTime))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Source: \(context.state.source)")
                        .font(.caption)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.attributes.articleCount) Articles")
                        .font(.caption2)
                        .foregroundColor(.accentColor)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.title)
                        .font(.caption)
                        .bold()
                        .lineLimit(1)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Published: \(context.state.publishedRange.lowerBound.formatted(.dateTime)) - \(context.state.publishedRange.upperBound.formatted(.dateTime))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            } compactLeading: {
                Text("\(context.attributes.articleCount) Art.")
                    .font(.caption2)
            } compactTrailing: {
                Text(context.state.source.prefix(3))
                    .font(.caption2)
            } minimal: {
                Text("\(context.state.author.prefix(1))")
                    .font(.caption2)
            }
            .keylineTint(.accentColor)
        }
    }
}

extension NewsAppIOSWidgetAttributes {
    fileprivate static let preview: NewsAppIOSWidgetAttributes = NewsAppIOSWidgetAttributes(articleCount: 2)
}

extension NewsAppIOSWidgetAttributes.ContentState {
    fileprivate static let activityState = NewsAppIOSWidgetAttributes.ContentState(source: "The Washington Post", author: "Hannah Docter-Loeb", title: "Americans see disparities in mental and physical care, survey finds - The Washington Post", publishedRange: Date()...Date().addingTimeInterval(15 * 60))
}

#Preview("Notification", as: .content, using: NewsAppIOSWidgetAttributes.preview) {
    NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.activityState
}
