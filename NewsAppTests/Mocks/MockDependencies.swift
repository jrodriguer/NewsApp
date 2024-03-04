//
//  MockDependencies.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 4/3/24.
//

import Foundation
import Mocker

@testable import NewsApp
class MockDependencies {
    init() {
        self.injectDependencies()
    }
    
    private func injectDependencies() {
        if let apiUrl: String = Configuration.value(for: .API_URL) {
            @Provider var auth = BackendApi(apiUrl: apiUrl) as BackendApiProtocol
        }
    }
}
