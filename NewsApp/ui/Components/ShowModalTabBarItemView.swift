//
//  ShowModalTabBarItemView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/24.
//

import SwiftUI

struct ShowModalTabBarItemView: View {
    let radius: CGFloat
    let action: () -> Void

    public init(radius: CGFloat, action: @escaping () -> Void) {
        self.radius = radius
        self.action = action
    }

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: radius, height: radius, alignment: .center)
                .foregroundColor(Color(.systemBlue))
                .background(Color(.white))
                .cornerRadius(radius/2)
                .overlay(RoundedRectangle(cornerRadius: radius/2).stroke(Color(.blue), lineWidth: 2))
        }
        .frame(width: radius, height: radius)
        .onTapGesture(perform: action)
    }
}

#Preview {
    ShowModalTabBarItemView(radius: 55) {
        print("Button tapped")
    }
}
