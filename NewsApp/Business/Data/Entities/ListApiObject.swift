//
//  ListApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation

struct ListApiObject<T: Codable>: Codable {
    var status: String
    var totalResults: Int
    var articles: [T]
}
