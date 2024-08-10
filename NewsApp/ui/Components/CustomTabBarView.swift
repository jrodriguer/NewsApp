//
//  CustomTabBarView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/24.
//

import SwiftUI

enum Tabs: Int {
    case News
    case Favorites
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tabs
    @Binding var showModal: Bool
    
    var body: some View {
        HStack {
            Button {
                selectedTab = .News
            } label: {
                TabBarButtonView(buttonText: "News", imageName: "network", isActive: selectedTab == .News)
            }
            .accessibilityIdentifier("NewsButton")
            .tint(Color(.gray))

            Button {
                showModal.toggle()
            } label: {
                ShowModalTabBarItemView(radius: 55) { showModal.toggle() }
            }
            .accessibilityIdentifier("ShowModalButton")
            
            Button {
                selectedTab = .Favorites
            } label: {
                TabBarButtonView(buttonText: "Favorites", imageName: "suit.heart", isActive: selectedTab == .Favorites)
            }
            .accessibilityIdentifier("FavoritesButton")
            .tint(Color(.gray))
        }
        .background(Color(.white))
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.News), showModal: .constant(false))
}
