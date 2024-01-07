//
//  RootView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Tabs = .personal
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Spacer()
        
        Headers()
        
        CustomTabBar(selectedTab: $selectedTab)
    }
}

#Preview {
    RootView()
}
