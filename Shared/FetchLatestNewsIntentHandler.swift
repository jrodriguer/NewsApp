//
//  FetchLatestNewsIntentHandler.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/6/24.
//

import CoreLocation
import Intents

class FetchLatestNewsIntentHandler: NSObject, FetchLatestNewsIntentHandling {

    func resolveCategory(for intent: FetchLatestNewsIntent, with completion: @escaping (CategoryTypeResolutionResult) -> Void) {
        if intent.category == .unknown {
            completion(CategoryTypeResolutionResult.needsValue())
        } else {
            completion(CategoryTypeResolutionResult.success(with: intent.category))
        }
    }
    
    func handle(intent: FetchLatestNewsIntent, completion: @escaping (FetchLatestNewsIntentResponse) -> Void) {
        let category = intent.category
    }
}
