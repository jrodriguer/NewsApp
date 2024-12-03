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
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: item.image ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        WrongImageView()
                    case .empty:
                        EmptyView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .frame(maxHeight: 300)
                .cornerRadius(10)
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(item.displayTitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text(item.displayAuthor)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(item.description ?? "")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                        .padding(.bottom, 8)
                    
                    Text("Content:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(item.displayContent)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                        .padding(.bottom, 2)
                    
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
                .padding()
            }
        }
        .navigationTitle("\(item.source)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
