//
//  TimeDifference.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/1/24.
//

import SwiftUI

struct TimeDifference: View {
    let published: Date
    
    // TODO: Add difference time from article published to today date.
            
    var body: some View {
        Divider()
        VStack(alignment: .leading, spacing: 8) {
            Text(published.formatted(date: .long, time: .shortened))
                .fontWeight(.light)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    TimeDifference(published: ModelData().news.articles[1].publishedAt)
}
