//
//  TabBarButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/24.
//

import SwiftUI

struct TabBarButtonView: View {
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            if isActive {
                Rectangle()
                    .frame(width: geo.size.width / 2, height: 8)
                    .padding(.leading, geo.size.width / Spacing.minimum)
            }
            
            VStack(alignment: .center, spacing: Spacing.minimum) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
//                Text(buttonText)
//                    .font(.h2)
            }
            .foregroundStyle(isActive ? .primary : .secondary)
            .frame(width: geo.size.width, height: geo.size.height)
            .accessibilityIdentifier(buttonText)
        }
    }
}
