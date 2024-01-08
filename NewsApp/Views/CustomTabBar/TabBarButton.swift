//
//  TabBarButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct TabBarButton: View {
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            if isActive {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
            }
            
            VStack(alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(buttonText)
                //TODO: Add font from .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    TabBarButton(buttonText: "Personal", imageName: "person.crop.circle", isActive: true)
}
