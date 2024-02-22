//
//  CharacterDetailView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 20/2/24.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: CharacterApiObject
    @EnvironmentObject var vm: CharacterViewModel
    
    @State private var index = 0
    
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
                        //.font(.customCalligraffitti(size: 18))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Status: \(character.status)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if let origin = character.origin {
                        Text("Origin: \(origin.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let location = character.location {
                        Text("Location: \(location.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                
                VStack {
                    TabView(selection: $index) {
                        ForEach((0..<3), id: \.self) { index in
                            Rectangle()
                                .fill(Color.pink)
                                .border(Color.black)
                                .padding()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack(spacing: 2) {
                        ForEach((0..<3), id: \.self) { index in
                            Circle()
                                .fill(index == self.index ? Color(.secondaryAccent) : Color(.secondaryAccent).opacity(0.5))
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding()
                }
                .frame(height: 200)
                
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
