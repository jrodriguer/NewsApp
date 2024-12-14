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
