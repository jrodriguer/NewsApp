//
//  DependencyInjector.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/3/24.
//

import SwiftUI

class DependencyInjector {
    private static var dependencyList: [String: Any] = [:]
    
    static func resolve<T>() -> T? {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("No provider register for type: \(T.self)")
        }
        return t
    }
    
    static func register<T>(dependency: T) {
        dependencyList[String(describing: T.self)] = dependency
    }
}

@propertyWrapper struct Inject<T> {
    var wrappedValue: T?
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
        Log.verbose("Injected <- \(String(describing: self.wrappedValue))")
    }
}
