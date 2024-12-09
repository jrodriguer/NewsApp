//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var item: ArticleListItemViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(image: item.image)
                    .frame(maxHeight: 300)
                    .cornerRadius(10)
                    .padding(Spacing.medium)
                
                VStack(alignment: .leading, spacing: Spacing.medium) {
                    Text(item.displayTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    if !item.displayAuthor.isEmpty {
                        Text(item.displayAuthor)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(item.description ?? "")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                    
                    if !item.displayContent.isEmpty {
                        Text(item.displayContent)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }
                    
                    HStack {
                        Link(destination: URL(string: item.link)!) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                        }
                        Button {
//                            if favorites.contains(item) {
//                                favorites.remove(item)
//                            } else {
//                                favorites.add(item)
//                            }
                        } label: {
//                            if favorites.contains(item) {
//                                Label {
//                                    Text("Remove from Favorites")
//                                } icon: { }
//                            } else {
//                                Label {
//                                    Text("Add to Favorites")
//                                } icon: { }
//                            }
                            
                            Label {
                                Text("Add to Favorites")
                            } icon: {
                                
                            }
                        }
                        .accessibilityIdentifier("FavoritesButton")
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                .padding(Spacing.medium)
            }
        }
        .navigationTitle("\(item.source)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
