//
//  RootView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Tabs = .Headers
    @State private var showModal: Bool = false
    
    var body: some View {
        CurrentView(currentView: self.$selectedTab)
        CustomTabBar(selectedTab: $selectedTab, showModal: $showModal)
    }
}

#Preview {
    RootView()
}
