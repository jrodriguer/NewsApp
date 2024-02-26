//
//  Utils.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/1/24.
//

import Foundation

class Utils {
    static func displayTitle(_ title: String) -> String {
        let components = title.components(separatedBy: " - ")
        return components.first ?? title
    }
    
    static func displayAuthor(_ author: String) -> String {
        let authors = author.components(separatedBy: ",")
        if let firstName = authors.first {
            return firstName.trimmingCharacters(in: .whitespacesAndNewlines) + (authors.count > 2 ? "..." : "")
        } else {
            return author
        }
    }
    
    static func displayContent(_ content: String?) -> String {
        guard let content = content else {
            return ""
        }
        return content.replacingOccurrences(of: "\\[.*\\]", with: "", options: .regularExpression)
    }
    
    static func timeDifference(from date: Date) -> String {
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: currentDate)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
}
