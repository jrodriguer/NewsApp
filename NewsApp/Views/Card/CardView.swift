//
//  CardView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import SwiftUI

struct CardView: View {
    var imageURL: URL?
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            imageURL.map {
                AsyncImage(url: $0) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(height: 200)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
            HStack {
                VStack(alignment: .leading) {
                    //Text(category)
                        //.font(.headline)
                        //.foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(author.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                
                Spacer()
            }
            .padding()
        }
    }
}
