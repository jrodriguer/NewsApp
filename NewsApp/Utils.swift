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
            return firstName.trimmingCharacters(in: .whitespacesAndNewlines) + (authors.count > 1 ? "..." : "")
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
}
