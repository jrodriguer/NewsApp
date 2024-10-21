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
}
