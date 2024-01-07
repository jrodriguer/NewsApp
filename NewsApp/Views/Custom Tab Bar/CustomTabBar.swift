//
//  CustomTabBar.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack {
            Button {
                // Switch to Personal
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: 59, height: 2)
                    Image(systemName: "person.crop.circle")
                        .frame(width: 24, height: 24)
                    Text("Personal")
                        //.font(Font.tabBar)
                }
            }
            
            Button {
                // Switch to Headers
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: "network")
                        .frame(width: 24, height: 24)
                    Text("Headers")
                        //.font(Font.tabBar)
                }
            }
            
            Button {
                // Switch to Favorites
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: "heart")
                        .frame(width: 24, height: 24)
                    Text("Favorites")
                        //.font(Font.tabBar)
                }
            }
        }
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBar()
}
