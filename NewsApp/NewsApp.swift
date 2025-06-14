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
    private let dependencies = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(viewModel: dependencies.makeArticleViewModel())
            }
        }
    }
    
    init() {
        // Navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.largeTitle.size)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.primary, .font: UIFont(name: "NotoSans-ExtraBold", size: TextDefinitions.headLine.size)!]
        navBarAppearance.backgroundColor = .white
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        try? Tips.configure()
    }
}
