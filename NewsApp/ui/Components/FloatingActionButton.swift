//
//  FloatingActionButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButton: View {
    var nameIcon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: nameIcon)
                .font(.title2.weight(.bold))
                .foregroundColor(.white)
                .padding()
                .background(Color(white: 0.4745))
                .clipShape(Circle())
                .shadow(radius: 5, x: 0, y: 3)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButton(nameIcon: "chevron.up", action: {})
}
