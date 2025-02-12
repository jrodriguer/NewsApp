//
//  ScrollContainer.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/25.
//

import SwiftUI

struct ScrollContainer<Content: View>: View {
    let articles: [ArticleListItemViewModel]
    let content: (ArticleListItemViewModel) -> Content
    @Binding var showFab: Bool
    let handleScrollOffset: (CGFloat) -> Void
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    scrollContent
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey.self,
                                                   value: -$0.frame(in: .named("scroll")).origin.y)
                        })
                        .onPreferenceChange(ViewOffsetKey.self) { handleScrollOffset($0) }
                }
                .coordinateSpace(.named("scroll"))
                
                fabButton(scrollProxy: scrollProxy)
            }
        }
    }
    
    @ViewBuilder
    private var scrollContent: some View {
        VStack {
//            if viewModel.shouldShowLoader() {
//                ProgressView()
//            } else {
            ForEach(articles) { article in
                content(article)
                    .id(article.id)
            }
            
        }
    }
    
    @ViewBuilder
    private func fabButton(scrollProxy: ScrollViewProxy) -> some View {
        if showFab {
            Button {
                scrollToTop(scrollProxy)
            } label: {
                Image(systemName: "chevron.up")
                    .font(.largeTitle)
                    .frame(width: 55, height: 55)
            }
            .buttonStyle(FabButtonStyle())
            .accessibilityIdentifier("FabButton")
        }
    }
    
    private func scrollToTop(_ proxy: ScrollViewProxy) {
        guard let firstArticleId = articles.first?.id else { return }
        DispatchQueue.main.async {
            withAnimation {
                proxy.scrollTo(firstArticleId, anchor: .top)
            }
        }
    }
}
