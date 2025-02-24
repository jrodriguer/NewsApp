//
//  ArticleListItemViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 21/10/24.
//

import Foundation

struct ArticleListItemViewModel: Identifiable, Encodable, Decodable, Hashable {
    let id: UUID
    let source: String
    let author: String?
    let title: String
    let description: String?
    let link: String
    let publishedAt: String
    let content: String?
    let image: String?
    
    init(
        id: UUID,
        source: String,
        author: String? = nil,
        title: String,
        description: String? = nil,
        link: String,
        publishedAt: String,
        content: String? = nil,
        image: String? = nil
    ) {
        self.id = id
        self.source = source
        self.author = author
        self.title = title
        self.link = link
        self.publishedAt = publishedAt
        self.content = content
        self.description = description
        self.image = image
    }
    
    var displayTitle: String {
        let components = title.components(separatedBy: " - ")
        return components.first ?? title
    }
    
    var displayAuthor: String {
        guard let author = author, !author.isEmpty else { return "" }
        if author.lowercased().hasPrefix("https://") { return "" }
        let authors = author.components(separatedBy: ",")
        if let firstName = authors.first {
            return firstName.localizedCapitalized.trimmingCharacters(in: .whitespacesAndNewlines) + (authors.count > 2 ? "..." : "")
        }
        return author
    }
    
    var displayContent: String {
        guard let content = content, !content.isEmpty else { return "" }
        return content.replacingOccurrences(of: "\\[.*\\]", with: "", options: .regularExpression)
    }
    
    var publishedStringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: publishedAt)
        return date ?? Date()
    }
    
//    static func timeDifference(from date: Date) -> String {
//        let currentDate = Date()
//        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: currentDate)
//        
//        if let year = components.year, year > 0 {
//            return "\(year) year\(year == 1 ? "" : "s") ago"
//        } else if let month = components.month, month > 0 {
//            return "\(month) month\(month == 1 ? "" : "s") ago"
//        } else if let day = components.day, day > 0 {
//            return "\(day) day\(day == 1 ? "" : "s") ago"
//        } else if let hour = components.hour, hour > 0 {
//            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
//        } else if let minute = components.minute, minute > 0 {
//            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
//        } else {
//            return "Just now"
//        }
//    }
}
