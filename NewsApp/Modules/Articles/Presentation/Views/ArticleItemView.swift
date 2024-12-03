//
//  ArticleItemView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleItemView: View {
    var item: ArticleListItemViewModel
    
    var body: some View {
        VStack {
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
            HStack {
                VStack(alignment: .leading) {
                    Text(item.source)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(item.displayTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Divider()
                    
                    HStack(alignment: .top) {
                        Text(item.publishedAt)
                        Text(item.displayAuthor)
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(
                    .sRGB,
                    red: 150/255,
                    green: 150/255,
                    blue: 150/255,
                    opacity: 0.1
                ), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
