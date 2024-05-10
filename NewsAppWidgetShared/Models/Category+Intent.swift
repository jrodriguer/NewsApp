//
//  Category+Intent.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/5/24.
//

import Foundation

extension Category {
    init(_ categoryIntentParam: CategoryIntentParam) {
        switch categoryIntentParam {
        case .general: self = .general
        case .business: self = .business
        case .technology: self = .technology
        case .entertainment: self = .entertainment
        case .sports: self = .sports
        case .science: self = .science
        case .health: self = .health
        case .unknown: self = .general
        }
    }
}
