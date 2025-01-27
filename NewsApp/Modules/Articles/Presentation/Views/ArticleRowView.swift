//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var article: ArticleListItemViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<ArticleListItemViewModel>
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            HStack {
                Text(article.displayTitle)
                    .applyStyle(.headLine)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .scaleEffect(isPressed ? 0.90 : 1.0, anchor: .center)
                
                Spacer()
                
                // TODO: Remove from this, add button.
                if favorites.contains(article) {
                    Image(systemName: "heart.fill")
                        .accessibilityLabel("This is a favorite article")
                        .foregroundStyle(.accent)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .cornerRadius(8)
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
