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
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    Text("Status: \(character.status)")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    //!! TODO: Add link to Location view (from character id), print the following data: type, dimension and residents.
                    /*if let origin = character.origin {
                        Text("Origin: \(origin.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }*/
                    
                    if let origin = character.origin {
                        CollapsibleView(
                            label: {
                                Text("Origin: \(origin.name)")
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
                                .padding()
                                .background(Color(.baseGray))
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                    
                    //Divider()
                    
                    //!! TODO: Add link to Location view (from character id), print the following data: type, dimension and residents.
                    if let location = character.location {
                        /*Text("Location: \(location.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)*/
                        
                        CollapsibleView(
                            label: {
                                Text("Location: \(location.name)")
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
                                .padding()
                                .background(Color(.baseGray))
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                    
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
