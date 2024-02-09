//
//  WrongImage.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct WrongImage: View {
    var body: some View {
        Image(systemName: "photo.circle.fill")
            .resizable()
            .foregroundColor(.gray)
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 100)
            .padding(.vertical, 10)
            .opacity(0.6)
    }
}

#Preview {
    WrongImage()
}
