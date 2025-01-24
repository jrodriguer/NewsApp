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
    static let largeTitle = TextDefinition(size: 34, weight: .medium, lineHeight: 34)
    static let h1 = TextDefinition(size: 28, weight: .medium, lineHeight: 34)
    static let h2 = TextDefinition(size: 22, weight: .medium, lineHeight: 28)
    static let h3 = TextDefinition(size: 20, weight: .regular, lineHeight: 26)
    static let headLine = TextDefinition(size: 17, weight: .semiBold, lineHeight: 22)
    static let body = TextDefinition(size: 17, weight: .regular, lineHeight: 22)
    static let subHead = TextDefinition(size: 15, weight: .regular, lineHeight: 20)
    static let footNote = TextDefinition(size: 13, weight: .semiBold, lineHeight: 16)
}
