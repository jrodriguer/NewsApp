//
//  StringExtension.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 2/3/24.
//

import Foundation

extension String {
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
