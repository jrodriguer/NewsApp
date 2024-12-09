//
//  WrongImageView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 10/1/24.
//

import SwiftUI

struct WrongImageView: View {
    var body: some View {
        Image(systemName: "photo.circle.fill")
            .resizable()
            .foregroundColor(Color.secondary)
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 100)
            .padding(.vertical, 12)
            .opacity(0.6)
    }
}

#Preview {
    WrongImageView()
}
