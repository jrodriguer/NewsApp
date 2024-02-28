//
//  CharacterDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 20/2/24.
//

import SwiftUI
import WebKit

struct CharacterDetailView: View {
    var character: CharacterApiObject
    @EnvironmentObject var vm: CharacterViewModel
    @EnvironmentObject var favorites: FavoritesViewModel<CharacterApiObject>
    
    @State private var showWebView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: character.image) { phase in
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
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("Species: \(character.species)")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    Text("Status: \(character.status)")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    Text("Origin: \(character.origin.name)")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    CollapsibleView(
                        label: {
                            Text("Location: \(character.location.name)")
                                .font(.body)
                                .foregroundColor(.primary)
                        },
                        content: {
                            HStack {                                
                                Text("Content")
                                 .font(.subheadline)
                                 .foregroundColor(.secondary)
                                 
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .onAppear { }
                            .onDisappear { }
                            .padding()
                            .background(Color(.baseGray))
                        }
                    )
                    .frame(maxWidth: .infinity)
                    
                    
                    HStack {
                        if let wikiURL = URL(string: "https://rickandmorty.fandom.com/wiki/\(character.name)?so=search") {
                            Link(destination: wikiURL) {
                                Image(systemName: "link.circle.fill")
                                    .font(.largeTitle)
                            }
                        } else {
                            Text("Invalid URL")
                        }
                        
                        Button {
                            if favorites.contains(character) {
                                favorites.remove(FavoriteKey.characterFavorite, value: character)
                            } else {
                                favorites.add(FavoriteKey.characterFavorite, value: character)
                            }
                        } label: {
                            if favorites.contains(character) {
                                Label {
                                    Text("Remove from Favorites")
                                } icon: {
                                    //
                                }
                            } else {
                                Label {
                                    Text("Add to Favorites")
                                } icon: {
                                    //
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
