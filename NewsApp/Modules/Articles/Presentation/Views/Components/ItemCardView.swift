//
//  ItemCardView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ItemCardView: View {
    @EnvironmentObject var favorites: BookmarkViewModel
    var item: ArticleListItemViewModel

    var body: some View {
        VStack {
            ImageView(image: item.image)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(item.displayTitle)
                    .foregroundStyle(Color.primary)
                    .applyStyle(.h2)
                
                Divider()
                
                HStack {
                    Text(item.publishedAt)
                        .foregroundStyle(Color.secondary)
                        .applyStyle(.footNote)
                        .frame(alignment: .top)
                    
                    Spacer()
                    
                    Button {
                        favorites.toggle(item)
                    } label: {
                        Image(systemName: favorites.contains(item) ? "bookmark.fill" : "bookmark")
                            .foregroundStyle(Color.primary)
                            .accessibilityLabel("Bookmark this item")
                    }
                }
                .padding(.trailing, 8)
            }
            .layoutPriority(100)
            .multilineTextAlignment(.leading)
            .padding(12)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.secondary.opacity(0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal], 12)
    }
}
