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

#Preview {
    CardView(imageURL: URL(string: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/01-07-2024/t_542a740c3bec4840811b74a7f8030823_name_UG3Y5CBFJHTU37IQY74PED45AE.jpg&w=1440"), heading: "Israel-Gaza war live updates: Blinken in Middle East as U.S. seeks to avert war between Israel and Hezbollah - The Washington Post", author: "Niha Masih, Jennifer Hassan, John Hudson, Yasmeen Abutaleb, Shane Harris")
}
