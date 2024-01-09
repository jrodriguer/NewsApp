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
    var description: String
    
    var body: some View {
        VStack {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
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
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0))
            } else {
                // TODO: Check another data of wrong images
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                    .cornerRadius(10)
                    .padding()
            }
            
            VStack(alignment: .leading) {
                Text(heading)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .padding([.vertical, .bottom], 14.976)
                Text(author.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .padding(.bottom, 12.8)
            }
            .padding(.horizontal, 4)
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(10)
    }
}

#Preview {
    CardView(imageURL: URL(string: "https://scitechdaily.com/images/Neptune-and-Uranus-True-Colors.jpg"), heading: "Astronomical Illusions: New Images Reveal What Neptune and Uranus Really Look Like - SciTechDaily", author: "SciTechDaily", description: "Recent research led by Professor Patrick Irwin shows that Neptune and Uranus are both a similar shade of greenish-blue, challenging previous perceptions of their colors. The study used modern telescopic data to correct historical color inaccuracies and explai…")
    
}
