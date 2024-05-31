//
//  Category.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 29/5/24.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
}

extension Category: Identifiable {
    var id: Self { self }
}
