//
//  StatusEnum.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/3/24.
//

import Foundation

enum StatusEnum: String, CaseIterable, Identifiable {
    case none = ""
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
}

extension StatusEnum {
    var value: String {
        get {
            if self == .none { return "none".localizedString() }
            return self.rawValue.localizedString()
        }
    }
}
