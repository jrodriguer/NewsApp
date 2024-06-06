//
//  FloatingActionButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButtonView: View {
    var name: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: name)
                .font(.largeTitle)
                .frame(width: 77, height: 70)
                .padding(.bottom, 7)
        }
        .background(Color(.baseGray))
        .cornerRadius(38.5)
        .foregroundStyle(Color.white)
        .padding()
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3)
    }
}

#Preview {
    FloatingActionButtonView(name: "chevron.baseGray", action: {})
}
