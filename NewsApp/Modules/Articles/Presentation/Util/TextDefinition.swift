//
//  TextDefinition.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/12/24.
//

import Foundation

struct TextDefinition {
    let size: CGFloat
    let weight: NotoSans
    let lineHeight: CGFloat
}

enum TextDefinitions {
    static let largeTitle = TextDefinition(size: 34, weight: .medium, lineHeight: 40) // 117.6%
    static let h1 = TextDefinition(size: 28, weight: .medium, lineHeight: 32) // 114.3%
    static let h2 = TextDefinition(size: 22, weight: .medium, lineHeight: 26) // 118%
    static let h3 = TextDefinition(size: 20, weight: .regular, lineHeight: 24) // 120%
    static let headLine = TextDefinition(size: 17, weight: .semiBold, lineHeight: 20) // 117.6%
    static let body = TextDefinition(size: 17, weight: .regular, lineHeight: 22) // 129.4%
    static let subHead = TextDefinition(size: 15, weight: .regular, lineHeight: 17) // 15 × 1.13 → 113%
    static let footNote = TextDefinition(size: 13, weight: .regular, lineHeight: 16) // 123%
}
