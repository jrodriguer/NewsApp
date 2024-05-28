//
//  Configuration.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 4/3/24.
//

import Foundation

enum Configuration {
    enum Key: String {
        case API_URL
    }
    
    /// Retrieve a typed value for a specific configuration key from the Info.plist file.
    ///
    /// - Parameter key: The configuration key.
    /// - Returns: The typed value for the specified key, or nil if not found or conversion fails.
    static func value<T>(for key: Key) -> T? where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            Log.warning(tag: Configuration.self, message: "Value not found for key: \(key.rawValue)")
            return nil
        }
        
        if let stringValue = object as? String {
            guard let value = T(stringValue.trimmingCharacters(in: .whitespaces)) else {
                Log.warning(tag: Configuration.self, message: "Failed to convert string to \(T.self) for key \(key.rawValue)")
                return nil
            }
            Log.info(tag: Configuration.self, message: "Value retrieved for key \(key.rawValue): \(value)")
            return value
        }
        Log.warning(tag: Configuration.self, message: "Unexpected type encountered for key \(key.rawValue)")
        return nil
    }
}
