//
//  RelatedArticlesView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 21/2/24.
//

import SwiftUI

struct RelatedArticlesView: View {
    var character: CharacterApiObject
    @EnvironmentObject var vm: ArticleViewModel
    
    var body: some View {
        // TODO: Replace with your logic
        let associatedCategory = "Science and Technology"
        
        // TODO: Fetch related articles based on the associated category
        
        /*if let articles = vm.getArticlesForCategory(category: associatedCategory) {
         VStack(alignment: .leading, spacing: 8) {
         Text("Related Articles")
         .font(.headline)
         .fontWeight(.bold)
         .foregroundColor(.primary)
         
         ForEach(articles) { article in
         NavigationLink(destination: ArticleDetailView(article: article)) {
         Text(article.title)
         .font(.subheadline)
         .foregroundColor(.primary)
         }
         }
         }
         .padding(.bottom, 8)
         }*/
    }
}

/*#Preview {
    RelatedArticlesView()
}*/
