//
//  View + Extension.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
    
    func subtitleStyle() -> some View {
        modifier(SubtitleStyle())
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.h1)
    }
}

struct SubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.h2)
    }
}
