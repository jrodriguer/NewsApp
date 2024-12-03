//
//  ArticleListLayout.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/12/24.
//

import SwiftUI

struct ArticleListLayout: View {
    let items: [ArticleListItemViewModel]

    var body: some View {
        ForEach(items, id: \.id) { item in
//            if item.title != "[Removed]" {
                NavigationLink(value: item) {
                    ArticleItemView(item: item)
                }
//            }
        }
        .navigationDestination(for: ArticleListItemViewModel.self, destination: { item in
            ArticleDetailView(item: item)
        })
    }
}
