//
//  ProcessInfo.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 4/3/24.
//

import Foundation

extension ProcessInfo {
    static var IS_UNIT_TESTING: Bool {
        return processInfo.environment["IS_UNIT_TESTING"] == "TRUE"
    }
}
