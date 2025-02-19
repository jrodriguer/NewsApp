//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/25.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject private var viewModel: BookmarkViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.bookmarks) { bookmark in
                            NavigationLink(destination: ArticleDetailView(article: bookmark)
                                .environmentObject(viewModel)) {
                                    ArticleCardView(article: bookmark)
                                        .environmentObject(viewModel)
                                }
                                .accessibilityIdentifier("NavigationLink_\(bookmark.id)")
                        }
                    }
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
}
