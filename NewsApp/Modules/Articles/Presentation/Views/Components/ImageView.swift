//
//  ImageView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import SwiftUI

struct ImageView: View {
    var image: String?
    
    var body: some View {
        AsyncImage(url: URL(string: image ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            case .failure:
                wrongImage
            case .empty:
                if image == nil {
                    wrongImage
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            @unknown default:
                wrongImage
            }
        }
    }

    private var wrongImage: some View {
        Image(systemName: "photo.circle.fill")
            .resizable()
            .foregroundStyle(.secondary)
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 100)
            .padding(.vertical, Spacing.medium)
            .opacity(0.6)
    }
}

#Preview {
    ImageView(image: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2154325960.jpg?c=16x9&q=w_800,c_fill")
}
