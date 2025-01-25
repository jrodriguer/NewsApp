//
//  NewsApp.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

@main
struct NewsApp: App {
    
    private let appDIContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            appDIContainer.homeView
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.largeTitle.size)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.headLine.size)!]
        navBarAppearance.backgroundColor = .white
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        UITabBar.appearance().barTintColor = UIColor(.white)
        UITabBar.appearance().backgroundColor = UIColor(.white)
        UITabBar.appearance().unselectedItemTintColor = UIColor(.secondary)
    }
}
