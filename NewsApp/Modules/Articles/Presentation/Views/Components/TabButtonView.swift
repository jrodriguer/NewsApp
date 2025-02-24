//
//  TabButton.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 24/2/25.
//

import SwiftUI

struct TabButton: View {
    let tabSelect: TabSelect
    @Binding var selectedTab: TabSelect
    
    var body: some View {
        Button(action: { selectedTab = tabSelect }) {
            Image(systemName: tabSelect.tabIcon)
                .renderingMode(.template)
            // this compares the selection to the button's associated enum.
            // The enum provides the image name to the button,
            // but we are always dealing with a case of the enum.
                .opacity(selectedTab == tabSelect ? (1) : (0.5))
                .padding()
        }
    }
}

//#Preview {
//    TabButton(tabSelect: Tab.news, selectedTab: Tab.constant(.bookmarks))
//}
