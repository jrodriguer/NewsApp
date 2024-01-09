//
//  Headers.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct HeadersView: View {
    @Environment(ModelData.self) var modelData
    var articles: [Article]
    
    var body: some View {
        ScrollView {
            VStack {
                if !articles.isEmpty {
                    ForEach(articles, id: \.id) { article in
                        if article.title != "[Removed]" {
                            CardView(imageURL: article.urlToImage, heading: article.title, author: article.author ?? "", description: article.description ?? "")
                        }
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
    let modelData = ModelData()
    return HeadersView(articles: modelData.news.articles)
        .environment(ModelData())
}
