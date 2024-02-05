//
//  FloatingActionButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButton: View {
    var nameIcon: String
    
    var body: some View {
        Button {
            //
        } label: {
            Image(systemName: nameIcon)
                .font(.title2.weight(.bold))
                .foregroundColor(.white)
                .padding()
                .background(.orange)
                .clipShape(Circle())
                .shadow(radius: 5, x: 0, y: 3)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButton(nameIcon: "chevron.up")
}
