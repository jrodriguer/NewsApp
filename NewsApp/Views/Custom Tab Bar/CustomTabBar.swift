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
                
            } label: {
                GeometryReader { geo in
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geo.size.width/2, height: 4)
                        .padding(.leading, geo.size.width/4)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("Personal")
                            //.font(Font.tabBar)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .tint(Color(.gray))
            
            Button {
                
            } label: {
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "network")
                            .frame(width: 32, height: 32)
                        Text("Headers")
                        //.font(Font.tabBar)
                    }
            }
            
            Button {
                
            } label: {
                GeometryReader { geo in
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geo.size.width/2, height: 4)
                        .padding(.leading, geo.size.width/4)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "heart")
                            .frame(width: 24, height: 24)
                        Text("Favorites")
                        //.font(Font.tabBar)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .tint(Color(.gray))
        }
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBar()
}
