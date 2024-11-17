//
//  NewsAppIOSWidget.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 30/10/24.
//

import WidgetKit
import SwiftUI

struct NewsAppIOSWidgetEntryView : View {
    let entry: ArticleEntry
    @Environment(\.widgetFamily) private var widgetFamily
    
    var body: some View {
        switch entry.state {
        case .articles(let articles):
            switch widgetFamily {
            case .systemSmall, .systemMedium:
                ArticleThumbnailView(article: articles.first ?? placeholderArticle, category: entry.category)
                    .widgetURL(articles.first?.url)
            case .systemLarge:
                ArticleEntryWidgetLargeView(articles: articles, category: entry.category)
            case .systemExtraLarge:
                ArticleEntryWidgetExtraLargeView(articles: articles, category: entry.category)
            default:
                EmptyView()
            }
        case .failure(let error):
            Text("Error: \(error)")
        }
    }
    
    private var placeholderArticle: ArticleWidgetModel {
        ArticleWidgetModel(
            id: UUID(),
            title: "Placeholder Article",
            description: "No articles available.",
            url: URL(string: "xcanewsapp://home")!
        )
    }
}

struct ArticleThumbnailView: View {
    let article: ArticleWidgetModel
    let category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.headline)
                .lineLimit(2)
            Text(category)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct ArticleEntryWidgetLargeView: View {
    let articles: [ArticleWidgetModel]
    let category: String

    var body: some View {
        VStack(alignment: .leading) {
            if let firstArticle = articles.first {
                Link(destination: firstArticle.url) {
                    Text(firstArticle.title)
                        .font(.headline)
                        .lineLimit(1)
                }
                Text(firstArticle.description)
                    .font(.caption)
                    .lineLimit(2)
            }
            ForEach(articles.dropFirst().prefix(3)) { article in
                Link(destination: article.url) {
                    Text("• \(article.title)")
                        .font(.caption)
                        .lineLimit(1)
                }
            }
        }
        .padding()
    }
}

struct ArticleEntryWidgetExtraLargeView: View {
    let articles: [ArticleWidgetModel]
    let category: String

    var body: some View {
        HStack {
            if let firstArticle = articles.first {
                Link(destination: firstArticle.url) {
                    Text(firstArticle.title)
                        .font(.headline)
                        .lineLimit(1)
                }
            }
            VStack(alignment: .leading) {
                ForEach(articles.dropFirst().prefix(5)) { article in
                    Link(destination: article.url) {
                        Text("• \(article.title)")
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding()
    }
}

struct NewsAppIOSWidget: Widget {
    let kind: String = "newsappioswidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: ArticleProvider()
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

//#Preview(as: .systemSmall) {
//    NewsAppIOSWidget()
//} timeline: {
//    ArticleEntry(date: .now, configuration: .smiley)
//    ArticleEntry(date: .now, configuration: .starEyes)
//}
