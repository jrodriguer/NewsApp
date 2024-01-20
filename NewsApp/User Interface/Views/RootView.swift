//
//  RootView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 8/1/24.
//

import SwiftUI

struct RootView: View {
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var favorites: Favorites
    @State private var selectedTab: Tabs = .Headers
    @State private var showModal: Bool = false
    
    var body: some View {
        CurrentView(currentView: self.$selectedTab)
        CustomTabBar(selectedTab: $selectedTab, showModal: $showModal)
    }
}

#Preview {
    RootView()
        .environment(ModelData())
        .environmentObject(Favorites())
}
