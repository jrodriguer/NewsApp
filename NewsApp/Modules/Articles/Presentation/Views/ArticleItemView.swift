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
            
            HStack {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Text(item.source)
                        .font(.h3)
                        .foregroundColor(Color.secondary)
                    Text(item.displayTitle)
                        .font(.h1)
                        .foregroundColor(Color.primary)
                        .lineLimit(3)
                    
                    Divider()
                                        
                    HStack(alignment: .top, spacing: Spacing.small) {
                        Text(item.publishedAt)
                        if !item.displayAuthor.isEmpty {
                            Text("𐤟")
                            Text(item.displayAuthor)
                        }
                    }
                    .font(.ligth)
                    .foregroundColor(Color.secondary)
                }
                .layoutPriority(100)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
