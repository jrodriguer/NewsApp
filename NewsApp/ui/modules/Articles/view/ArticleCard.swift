//
//  ArticleCard.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct ArticleCard: View {
    let article: ArticleApiObject
    
    var body: some View {
        VStack {
            if let imageURL = article.urlToImage {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure(_):
                        WrongImage()
                    case .empty:
                        EmptyView()
                    @unknown default:
                        ProgressView()
                    }
                }
                .cornerRadius(10)
            } else {
                WrongImage()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.source.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(Utils.displayTitle(article.title))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                
                Divider()
                
                HStack(alignment: .top, spacing: 4) {
                    Text(timeDifference(from: article.publishedAt))
                    
                    if let author = article.author {
                        Text("•")
                        Text(Utils.displayAuthor(author))
                    }
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(10)
    }
    
    private func timeDifference(from date: Date) -> String {
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date, to: currentDate)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
}
