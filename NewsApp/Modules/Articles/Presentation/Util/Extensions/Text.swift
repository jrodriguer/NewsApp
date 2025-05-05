//
//  Text + Definition.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/12/24.
//

import Foundation
import SwiftUI

extension Text {
    /// Apply a custom text style
    /// - Parameter style: Text style containing font and line height
    /// - Returns: Stylized view with line spacing modifier
    func applyStyle(_ style: TextStyle) -> some View {
        self.font(style.font)
            .lineSpacing(style.lineHeight - style.size)
    }
}

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
