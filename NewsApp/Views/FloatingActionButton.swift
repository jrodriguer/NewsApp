//
//  FloatingActionButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButton: View {
    @State var showFloatingActionButton = true
    @State var scrollOffset: CGFloat = 0.00
    
    var body: some View {
        Button {
            //
        } label: {
            Image(systemName: "plus")
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
    FloatingActionButton()
}
