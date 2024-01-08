//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    var articles: [Article]
    
    var body: some View {
        ScrollView {
            VStack {
                if !articles.isEmpty {
                    ForEach(articles, id: \.id) { article in
                        CardView(imageURL: article.urlToImage, category: "News", heading: article.title, author: article.author ?? "")
                    }
                } else {
                    Text("No articles available")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationBarTitle("Headers")
        }
    }
}

#Preview {
    HeadersView(articles: news.articles)
}
