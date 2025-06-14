//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleUIModel
    @EnvironmentObject var favorites: BookmarkViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ImageView(image: article.image)
                    .frame(maxHeight: 300)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(article.displayTitle)
                        .foregroundColor(.primary)
                        .applyStyle(.h1)
                        .multilineTextAlignment(.leading)
                    
                    if !article.displayAuthor.isEmpty {
                        Text(article.displayAuthor)
                            .foregroundColor(.secondary)
                            .applyStyle(.h2)
                    }
                    
                    Text(article.description ?? "")
                        .foregroundColor(.primary)
                        .applyStyle(.body)
                        .lineLimit(nil)
                    
                    if !article.displayContent.isEmpty {
                        Text(article.displayContent)
                            .applyStyle(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                }
                .padding()
                .safeAreaPadding(.bottom, 32)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
