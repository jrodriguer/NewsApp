//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var item: ArticleListItemViewModel
        
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(item.displayTitle)
                    .multilineTextAlignment(.leading)
                    .swipeActions(edge: .leading) {
                        Button {
//                            if favorites.contains(article) {
//                                favorites.remove(article)
//                            } else {
//                                favorites.add(article)
//                            }
                        } label: {
//                            if favorites.contains(article) {
//                                Label("Favorite", systemImage: "heart.slash")
//                            } else {
//                                Label("Favorite", systemImage: "suit.heart.fill")
//                            }                            
                        }
                        .tint(.red)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            if favorites.contains(article) {
//                Spacer()
//                Image(systemName: "heart.fill")
//                    .accessibilityLabel("This is a favorite article")
//                    .foregroundColor(.red)
//            }
            
            HStack {
                Text(item.source)
            }
            .foregroundColor(.primary)
            .font(.h2)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ArticleRowView(item: ArticleListItemViewModel(
        id: UUID(),
        source: "The Washington Post",
        author: "Hannah Docter-Loeb",
        title: "Americans see disparities in mental and physical care, survey finds - The Washington Post",
        link: "https://www.washingtonpost.com/wellness/2024/05/27/mental-health-treatment-disparity/",
        publishedAt: "2024-05-27T12:30:00Z")
    )
}
