//
//  CustomTabBarView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/2/24.
//

import SwiftUI

enum Tabs: Int {
    case Headers
    case Personal
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tabs
    @Binding var showModal: Bool
    
    var body: some View {
        HStack {
            Button {
                selectedTab = .Headers
            } label: {
                TabBarButtonView(buttonText: "Headers", imageName: "network", isActive: selectedTab == .Headers)
            }
            .tint(Color(.gray))

            Button {
                
            } label: {
                ShowModalTabBarItemView(radius: 55) { showModal.toggle() }
            }
            
            Button {
                selectedTab = .Personal
            } label: {
                TabBarButtonView(buttonText: "Characters", imageName: "face.smiling", isActive: selectedTab == .Personal)
            }
            .tint(Color(.gray))
        }
        .background(Color(.white))
        .frame(height: 82)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.Headers), showModal: .constant(false))
}
