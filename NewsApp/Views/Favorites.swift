//
//  Favorites.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct Favorites: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Favorites")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle("Favorites")
    }
}

#Preview {
    Favorites()
}
