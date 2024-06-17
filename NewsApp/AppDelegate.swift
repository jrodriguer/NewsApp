//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 23/2/24.
//

import Foundation
import UIKit
import Intents

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Application Delegate.\n")
        
        _ = Dependencies()
            
        INPreferences.requestSiriAuthorization { status in
            if status == .authorized {
                print("Siri authorization granted.")
                let intent = FetchLatestNewsIntent()
                let interaction = INInteraction(intent: intent, response: nil)
                interaction.donate { error in
                    if let error = error {
                        print("Failed to donate interaction: \(error.localizedDescription)")
                    }
                }
            }
        }
        return true
    }
}
