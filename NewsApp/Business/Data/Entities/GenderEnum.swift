//
//  GenderEnum.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/3/24.
//

import Foundation

public enum GenderEnum: String, CaseIterable, Identifiable {
    case none = ""
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    
    public var id: String { self.rawValue }
}

extension GenderEnum {
    var value: String {
        get {
            if self == .none { return "none".localizedString() }
            return self.rawValue.localizedString()
        }
    }
}
