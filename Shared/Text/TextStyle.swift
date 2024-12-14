//
//  TextStyle.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/12/24.
//

import Foundation
import SwiftUI

struct TextStyle {
    let font: Font
    let lineHeight: CGFloat
    let size: CGFloat

    static func from(_ definition: TextDefinition) -> TextStyle {
        let font = Font.from(definition)
        return TextStyle(font: font, lineHeight: definition.lineHeight, size: definition.size)
    }

    static let h1 = from(TextDefinitions.h1)
    static let h2 = from(TextDefinitions.h2)
    static let h3 = from(TextDefinitions.h3)
    static let headLine = from(TextDefinitions.headLine)
    static let body = from(TextDefinitions.body)
    static let subHead = from(TextDefinitions.subHead)
    static let footNote = from(TextDefinitions.footNote)
}
