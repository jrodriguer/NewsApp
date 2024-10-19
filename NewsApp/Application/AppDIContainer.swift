//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//

import Foundation

final class AppDIContainer {
    
    /// Configuration and initialization of DataTransferService.
    /// This service is created lazily, ensuring it’s only initialized when needed.
    lazy var apiDataTransferService: DataTransferService = {
        let networkConfig = ApiDataNetworkConfig(baseURL: AppConfiguration.baseURL)
        let sessionManager = DefaultNetworkSessionManager(session: SharedURLSession.shared)
        let networkManager = DefaultNetworkManager(networkConfig: networkConfig, sessionManager: sessionManager)
        return DefaultDataTransferService(networkManager: networkManager)
    }()
    
    
}
