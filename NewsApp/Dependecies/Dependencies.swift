//
//  Dependencies.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 4/3/24.
//

import Foundation

class Dependencies {
    init() {
        guard !ProcessInfo.IS_UNIT_TESTING else { return }
        self.injectDependencies()
    }
    
    private func injectDependencies() {
        if let apiUrl: String = Configuration.value(for: .API_URL) {
            @Provider var api = BackendApi(apiUrl: apiUrl) as BackendApiProtocol
        }
    }
}
