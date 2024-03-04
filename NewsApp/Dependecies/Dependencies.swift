//
//  Dependencies.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 4/3/24.
//

import Foundation

/// Responsible for injecting dependencies into the project.
class Dependencies {
    init() {
        guard !ProcessInfo.IS_UNIT_TESTING else { return }
        self.injectDependencies()
    }
    
    /// Instance register using @Provider.
    private func injectDependencies() {
        if let apiUrl: String = Configuration.value(for: .API_URL) {
            @Provider var auth = BackendApi(apiUrl: apiUrl) as BackendApiProtocol
        }
    }
}
