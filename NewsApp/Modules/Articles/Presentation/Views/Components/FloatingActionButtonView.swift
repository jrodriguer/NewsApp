//
//  FloatingActionButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/1/24.
//

import SwiftUI

struct FloatingActionButtonView: View {
    let name: String
    let radius: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: name)
                .font(.largeTitle)
                .aspectRatio(contentMode: .fit)
                .frame(width: radius, height: radius, alignment: .center)
        }
        .foregroundStyle(Color.white)
        .background(Color(.baseGray))
        .cornerRadius(radius/2)
        .padding()
    }
}
