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
        // TODO: More detail info.
        HStack {
            Text(item.displayTitle)
                .multilineTextAlignment(.leading)
                .swipeActions(edge: .leading) {
                    Button {
//                        if favorites.contains(article) {
//                            favorites.remove(article)
//                        } else {
//                            favorites.add(article)
//                        }
                    } label: {
//                        if favorites.contains(article) {
//                            Label("Favorite", systemImage: "heart.slash")
//                        } else {
//                            Label("Favorite", systemImage: "suit.heart.fill")
//                        }
                        
                        Label("Favorite", systemImage: "suit.slash")
                    }
                    .tint(.red)
                }
            
//            if favorites.contains(article) {
//                Spacer()
//                Image(systemName: "heart.fill")
//                    .accessibilityLabel("This is a favorite article")
//                    .foregroundColor(.red)
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}
