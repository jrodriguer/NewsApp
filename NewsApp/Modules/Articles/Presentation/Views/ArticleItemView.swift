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
                case .failure:
                    WrongImageView()
                case .empty:
                    if item.image == nil {
                        WrongImageView()
                    } else {
                        VStack {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100, alignment: .center)
                    }
                @unknown default:
                    WrongImageView()
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    Text(item.source)
                        .font(.headline)
                        .foregroundColor(Color.secondary)
                    Text(item.displayTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                        .lineLimit(3)
                    
                    Divider()
                                        
                    HStack(alignment: .top, spacing: Spacing.small) {
                        // TODO: Footer relayout.
//                        Text(item.publishedAt)
//                        Text(item.displayAuthor)
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.secondary)
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
                .stroke(Color.secondary.opacity(0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
