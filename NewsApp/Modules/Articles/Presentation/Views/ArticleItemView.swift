//
//  ArticleItemView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleItemView: View {
    var item: ArticleListItemViewModel
    
    var body: some View {
        VStack {
            ImageView(image: item.image)
            
            VStack(alignment: .leading, spacing: Spacing.medium) {
                Text(item.displayTitle)
                    .foregroundColor(Color.primary)
                    .applyStyle(.h1)
                
                Divider()
                
                HStack(alignment: .top, spacing: Spacing.medium) {
                    Text(item.publishedAt)
                        .applyStyle(.footNote)
                }
                .foregroundStyle(Color.secondary)
            }
            .layoutPriority(100)
            .multilineTextAlignment(.leading)
            .padding(Spacing.medium)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal], Spacing.medium)
    }
}
