//
//  CharacterDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 20/2/24.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: CharacterApiObject
    
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
                    
                    Text("Status: \(character.status)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // TODO: Add more details about the character, e.g., origin, location, etc.
                    
                    RelatedArticlesView(character: character)
                }
                .padding()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
