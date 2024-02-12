//
//  ListApiObject.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/2/24.
//

import Foundation

struct ListApiObject<T: Codable>: Codable {
    var status: String?
    var totalResults: Int?
    var info: Info?
    var items: [T]
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
