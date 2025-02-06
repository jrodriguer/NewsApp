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
                WrongImageView()
            case .empty:
                if image == nil {
                    WrongImageView()
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            @unknown default:
                WrongImageView()
            }
        }
    }
}

#Preview {
    ImageView(image: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2154325960.jpg?c=16x9&q=w_800,c_fill")
}
