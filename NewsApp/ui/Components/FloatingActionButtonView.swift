//
//  FloatingActionButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButtonView: View {
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
                .background(Color(.detail1))
                .clipShape(Circle())
                .shadow(radius: 5, x: 0, y: 3)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButtonView(nameIcon: "chevron.up", action: {})
}
