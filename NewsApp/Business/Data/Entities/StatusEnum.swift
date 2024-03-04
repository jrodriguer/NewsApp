//
//  Status.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/3/24.
//

import Foundation

enum Status: String, CaseIterable, Identifiable {
    case none = ""
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
}

extension Status {
    var value: String {
        get {
            if self == .none { return "none".localizedString() }
            return self.rawValue.localizedString()
        }
    }
}
