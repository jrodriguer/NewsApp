//
//  ArticleRow.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        HStack {
            Text(Utils.displayTitle(article.title))
        }
    }
}

#Preview {
    return ArticleRow(article: ModelData().news.articles[1])
}
