//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleRowView: View {
    var article: ArticleApiObject
    @EnvironmentObject var vm: ArticleViewModel
    
    var body: some View {
        HStack {
            Text(Utils.displayTitle(article.title))
                .swipeActions(edge: .leading) {
                    Button {
                        if vm.contains(article) {
                            vm.remove(article)
                        } else {
                            vm.add(article)
                        }
                    } label: {
                        if vm.contains(article) {
                            Label("Favorite", systemImage: "heart.slash")
                        } else {
                            Label("Favorite", systemImage: "heart.fill")
                        }
                    }
                    .tint(.red)
                }
            
            if vm.contains(article) {
                Spacer()
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite article")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ArticleRowView(article: ArticleViewModel().articles[1])
        .environmentObject(ArticleViewModel())
}
