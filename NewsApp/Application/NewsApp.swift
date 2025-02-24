//
//  NewsApp.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI
import TipKit

@main
struct NewsApp: App {
    
    private let appDIContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            appDIContainer.tabsView
        }
    }
    
    init() {
        /// Navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.largeTitle.size)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.headLine.size)!]
        navBarAppearance.backgroundColor = .white
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        /// Tab Bar Item
        let fontAttributesNormal = [NSAttributedString.Key.font: UIFont(name: "NotoSans-Regular", size: TextDefinitions.footNote.size)!]
        let fontAttributesSelected = [NSAttributedString.Key.font: UIFont(name: "NotoSans-Regular", size: TextDefinitions.footNote.size)!]
        
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributesSelected, for: .selected)
        
        UITabBar.appearance().barTintColor = UIColor(.white)
        UITabBar.appearance().backgroundColor = UIColor(.white)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.secondary)
        UITabBar.appearance().tintColor = UIColor(Color.primary)
        
        try? Tips.configure()
    }
}
