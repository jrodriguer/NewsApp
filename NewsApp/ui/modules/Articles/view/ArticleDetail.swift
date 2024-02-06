//
//  ArticleDetail.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetail: View {
    var article: ArticleApiObject
    @EnvironmentObject var vm: ArticleViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let imageURL = article.urlToImage {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(_):
                            WrongImage()
                        case .empty:
                            EmptyView()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding()
                } else {
                    WrongImage()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(Utils.displayTitle(article.title))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let author = article.author {
                        Text(author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let description = article.description {
                        Text(description)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 8)
                    }
                    
                    if let content = article.content {
                        Text("Content:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(Utils.displayContent(content))
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                            .padding(.bottom, 2)
                    }
                    
                    HStack {
                        Link(destination: article.url) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                        }
                        Button(vm.contains(article) ? "Remove from vm" : "Add to vm") {
                            if vm.contains(article) {
                                vm.remove(article)
                            } else {
                                vm.add(article)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Article from \(article.source.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
