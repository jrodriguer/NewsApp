//
//  NewsAppIOSWidgetAttributes.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/11/24.
//

import ActivityKit
import Foundation

/*
 A cumplir con una estructura de actividad (activityAttributes, Dynamic data), cuyo contenido
 sean aquellos datos más descriptivos, pero sin descripción como valor asociado, del artículo.
 El publishedRange sería aquel periodo de tiempo en el que se publicó el artículo.
 */

struct NewsAppIOSWidgetAttributes: ActivityAttributes {
    public typealias NewsAppIOSWidgetStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var source: String
        var author: String
        var title: String
        var publishedAt: String
        
        var publishedDate: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from:publishedAt)!
        }
        
        var timeSincePublished: String? {
            guard let publishedDate = publishedDate else { return "0min" }
            let timeInterval = Int(Date().timeIntervalSince(publishedDate))
            
            let days = timeInterval / 86400
            let hours = (timeInterval % 86400) / 3600
            let minutes = (timeInterval % 3600) / 60
            
            if timeInterval > days {
                return "\(days)d"
            } else if hours > 0 {
                return "\(hours)h"
            } else {
                return "\(minutes)min"
            }
        }
    }
    
    var id: String
}
