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
        var publishedRange: ClosedRange<Date> // Period of time in which the article were published
    }
    
    var id: String
}
