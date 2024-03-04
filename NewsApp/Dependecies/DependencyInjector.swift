//
//  DependencyInjector.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 3/3/24.
//

import SwiftUI

class DependencyInjector {
    private static var dependencyList: [String: Any] = [:]
    
    /// Internal a dependency for the given type.
    ///
    /// - Returns: An instance of the specified type, or nil if not found.
    static func resolve<T>() -> T? {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            // TODO: Choose to return an optional value (nil) instead of using fatalError.
            fatalError("No provider register for type: \(T.self)")
        }
        return t
    }
    
    /// Register a dependency with the container.
    ///
    /// - Parameter dependency: The instance of the dependency to register.
    static func register<T>(dependency: T) {
        dependencyList[String(describing: T.self)] = dependency
    }
}

/// Property wrapper for dependency injection.
@propertyWrapper struct Inject<T> {
    /// The wrapped value representing the resolved dependency.
    var wrappedValue: T?
    
    /// Initializes the property wrapper, resolving the dependency.
    init() {
        self.wrappedValue = DependencyInjector.resolve()
        Log.verbose("Injected <- \(String(describing: self.wrappedValue))")
    }
}

/// Property wrapper for providing dependencies to the container.
@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    /// Initializes the property wrapper and registers the dependency with the container.
    ///
    /// - Parameter wrappedValue: The instance of the dependency to register.
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
        Log.verbose("Provide -> \(self.wrappedValue)")
    }
}
