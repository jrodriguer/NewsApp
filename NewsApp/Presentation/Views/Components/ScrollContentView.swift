//
//  ScrollContentView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/25.
//

import SwiftUI

struct ScrollContentView<Content: View>: View {
    let articles: [ArticleUIModel]
    @ViewBuilder let content: (ArticleUIModel) -> Content
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
                
                if showFab {
                    FabButtonView(action: {
                        scrollToTop(scrollProxy)
                    })
                }
            }
        }
    }
    
    private var scrollContent: some View {
        VStack {
            ForEach(articles) { article in
                content(article)
                    .id(article.id)
            }
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
