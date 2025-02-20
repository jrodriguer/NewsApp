//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var article: ArticleListItemViewModel
    @EnvironmentObject var favorites: BookmarkViewModel
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            HStack {
                Text(article.displayTitle)
                    .applyStyle(.headLine)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .scaleEffect(isPressed ? 0.90 : 1.0, anchor: .center)
                
                Spacer()
                
                if favorites.contains(article) {
                    Image(systemName: "bookmark.fill")
                        .accessibilityLabel("This is a boorkmarked article")
                        .foregroundStyle(.accent)
                        
                }
            }
            .padding([.top, .horizontal], Spacing.medium)
            .animation(.easeInOut, value: isPressed)
            
            .onLongPressGesture(minimumDuration: 1.5, pressing: { isPressing in
                withAnimation {
                    isPressed = isPressing
                }
            }, perform: {
                favorites.toggle(article)
            })
        }
        
    }
}
