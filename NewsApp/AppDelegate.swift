//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 23/2/24.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Application Delegate.\n")
        #if DEBUG
        if CommandLine.arguments.contains("-ui-test") {
            resetToDefaultState()
        }
        #endif
        
        _ = Dependencies()
        
        return true
    }
}

extension AppDelegate {
    func resetToDefaultState() {
        
    }
}
