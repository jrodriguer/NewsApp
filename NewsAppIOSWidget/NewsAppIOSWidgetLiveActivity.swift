//
//  NewsAppIOSWidgetLiveActivity.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 30/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

/*
 A cumplir con una estructura de actividad (activityAttributes, Dynamic data), cuyo contenido
 sean aquellos datos más descriptivos, pero sin descripción como valor asociado, del artículo.
 El publishedRange sería aquel periodo de tiempo en el que se publicaron los artículos.
 Fuera, el número de aquellos artículos volcados en el tiempo indicado. Tiempo que el usuario,
 otra feature aparte, considerándose esta como cuenta regresiva, indique a escuchar.
 */

struct NewsAppIOSWidgetAttributes: ActivityAttributes {
    public typealias NewsAppIOSWidgetStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var source: String
        var author: String
        var title: String
        var publishedRange: ClosedRange<Date> // Period of time in which the articles were published
    }
    
    var numberOfArticles: Int
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
                    Text("\(context.attributes.numberOfArticles) Articles")
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
                Text("\(context.attributes.numberOfArticles) Art.")
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
    fileprivate static let preview: NewsAppIOSWidgetAttributes = NewsAppIOSWidgetAttributes(numberOfArticles: 2)
}

extension NewsAppIOSWidgetAttributes.ContentState {
    fileprivate static let activityState = NewsAppIOSWidgetAttributes.ContentState(source: "The Washington Post", author: "Hannah Docter-Loeb", title: "Americans see disparities in mental and physical care, survey finds - The Washington Post", publishedRange: Date()...Date().addingTimeInterval(15 * 60))
}

#Preview("Notification", as: .content, using: NewsAppIOSWidgetAttributes.preview) {
    NewsAppIOSWidgetLiveActivity()
} contentStates: {
    NewsAppIOSWidgetAttributes.ContentState.activityState
}
