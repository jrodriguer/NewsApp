//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleListItemViewModel
    @EnvironmentObject var favorites: BookmarkViewModel<ArticleListItemViewModel>
    
    var body: some View {
        ScrollView {
            VStack {
                ImageContainer(image: article.image)
                    .frame(maxHeight: 300)
                
                VStack(alignment: .leading, spacing: Spacing.medium) {
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
                    
                    // TODO: Apply bookmark in detail anyway.
//                    HStack {
//                        Link(destination: URL(string: article.link)!) {
//                            Image(systemName: "link.circle.fill")
//                                .font(.system(size: Spacing.large))
//                        }
//                    }
//                    .padding(.top, Spacing.medium)
                }
                .padding(Spacing.medium)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
