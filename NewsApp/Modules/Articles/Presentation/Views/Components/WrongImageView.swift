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
            .foregroundColor(Color(.gray))
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 100)
            .padding(.vertical, 10)
            .opacity(0.6)
    }
}
