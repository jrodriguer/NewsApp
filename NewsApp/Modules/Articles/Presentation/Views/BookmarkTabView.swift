//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/25.
//

import SwiftUI
import TipKit

struct BookmarkTabView: View {
    
    @EnvironmentObject private var viewModel: BookmarkViewModel
    private let bookmarkArticleTip = BookmarkArticleTip()
    
    var body: some View {
        NavigationStack {
            VStack {
                TipView(bookmarkArticleTip)
                    .textFieldStyle(.roundedBorder)
                    .tipViewStyle(CustomTipViewStyle())
                    .padding([.top, .horizontal], Spacing.medium)
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
