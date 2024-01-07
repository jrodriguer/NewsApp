//
//  CustomTabBar.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

enum Tabs: Int {
    case personal = 0
    case headers = 1
    case favorites = 2
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            Button {
                selectedTab = .personal
            } label: {
                TabBarButton(buttonText: "Personal", imageName: "person.crop.circle", isActive: selectedTab == .personal)
            }
            .tint(Color(.gray))
            
            Button {
                selectedTab = .headers
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: "network")
                        .frame(width: 32, height: 32)
                    Text("Headers")
                    //.font(Font.tabBar)
                }
            }
            
            Button {
                selectedTab = .favorites
            } label: {
                TabBarButton(buttonText: "Favorites", imageName: "heart", isActive: selectedTab == .favorites)
            }
            .tint(Color(.gray))
        }
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.personal))
}
