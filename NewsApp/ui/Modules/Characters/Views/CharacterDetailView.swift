//
//  CharacterDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 20/2/24.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: CharacterApiObject
    @EnvironmentObject var favorites: CharacterFavoritesViewModel
    
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
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("Status: \(character.status)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    if let origin = character.origin {
                        Text("Origin: \(origin.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    if let location = character.location {
                        Text("Location: \(location.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    //!! TODO: Add link to Location view (from character id).

                    HStack {
                        Link(destination: character.url) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                        }
                        Button(favorites.contains(character) ? "Remove from Favorites" : "Add to Favorites") {
                            if favorites.contains(character) {
                                favorites.remove(character)
                            } else {
                                favorites.add(character)
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

// TODO: Add SwifUI Preview.
