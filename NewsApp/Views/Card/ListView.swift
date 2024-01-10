//
//  ListView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/24.
//

import SwiftUI

struct ListView: View {
    var article: Article
    
    var body: some View {
        HStack {
            Text(article.title)
            
            Spacer()
            
            
        }
    }
}

#Preview {
    let articles = ModelData().news.articles
    return Group {
        ListView(article: articles[0])
        ListView(article: articles[1])
    }
}
    
