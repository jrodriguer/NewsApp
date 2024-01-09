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
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)
                    .padding()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    .lineLimit(3)
                }
                Text(author.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .padding(.vertical, 1)
            }
            .layoutPriority(100)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CardView(imageURL: URL(string: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-07-2024/t_542a740c3bec4840811b74a7f8030823_name_UG3Y5CBFJHTU37IQY74PED45AE.jpg&w=1440"), heading: "Israel-Gaza war live updates: Blinken in Middle East as U.S. seeks to avert war between Israel and Hezbollah - The Washington Post", author: "Niha Masih, Jennifer Hassan, John Hudson, Yasmeen Abutaleb, Shane Harris", description: "The secretary of state’s tour is part of the U.S. effort to avoid regional escalation, in particular a war between Israel and the militant group in Lebanon.")
}
