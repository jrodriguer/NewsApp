//
//  NewsApp.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 7/1/24.
//

import SwiftUI

@main
struct NewsApp: App {
    
    // MARK: Use the UIApplicationDelegateAdaptor property wrapper to tell SwiftUI it should use your AppDelegate class.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
