//
//  CustomTabBar.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

enum Tabs: Int {
    case Headers
    case Favorites
}

// TODO: Check the Tab Bar always enable.

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    @Binding var showModal: Bool
    
    var body: some View {
        HStack {
            Button {
                selectedTab = .Headers
            } label: {
                TabBarButton(buttonText: "Headers", imageName: "network", isActive: selectedTab == .Headers)
            }
            .tint(Color(.gray))
            
            Button {
                
            } label: {
                ShowModalTabBarItem(radius: 55) { showModal.toggle() }
            }
            
            Button {
                selectedTab = .Favorites
            } label: {
                TabBarButton(buttonText: "Favorites", imageName: "heart", isActive: selectedTab == .Favorites)
            }
            .tint(Color(.gray))
        }
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.Headers), showModal: .constant(false))
}
