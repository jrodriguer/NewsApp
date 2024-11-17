//
//  NewsAppIOSWidget.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 30/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct ArticleEntry: TimelineEntry {
    enum State {
        case articles([ArticleWidgetModel])
        case failure(String)
    }
    
    let date: Date
    let state: State
    let category: String
}

struct NewsAppIOSWidgetEntryView : View {
    let entry: ArticleEntry
    @Environment(\.widgetFamily) private var widgetFamily
    
    var body: some View {
        switch entry.state {
        
        case .articles(let articles):
            switch widgetFamily {
            case .systemSmall, .systemMedium:
                ArticleThumbnailView(article: articles[0], category: entry.category)
                    .widgetURL(articles[0].url)
                
                
            case .systemLarge:
                ArticleEntryWidgetLargeView(articles: articles, category: entry.category)
                
            case .systemExtraLarge:
                ArticleEntryWidgetExtraLargeView(articles: articles, category: entry.category)
                

            default: EmptyView()
            }
            
        
        case .failure(let error):
            
            Text(error.localizedDescription)
            
            
        }
    }
}

struct NewsAppIOSWidget: Widget {
    let kind: String = "newsappioswidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            NewsAppIOSWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    NewsAppIOSWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
