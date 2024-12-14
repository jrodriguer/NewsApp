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
    static let h1 = TextDefinition(size: 27, weight: .medium, lineHeight: 34)
    static let h2 = TextDefinition(size: 21, weight: .medium, lineHeight: 28)
    static let h3 = TextDefinition(size: 19, weight: .regular, lineHeight: 26)
    static let headLine = TextDefinition(size: 16, weight: .semiBold, lineHeight: 22)
    static let body = TextDefinition(size: 16, weight: .regular, lineHeight: 22)
    static let subHead = TextDefinition(size: 14, weight: .regular, lineHeight: 20)
    static let footNote = TextDefinition(size: 12, weight: .regular, lineHeight: 16)
}
