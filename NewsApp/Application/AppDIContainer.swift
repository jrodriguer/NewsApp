//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//

import Foundation

final class AppDIContainer {
    
    lazy var apiDataTransferService: DataTransferService = {
        let networkConfig = ApiDataNetworkConfig(baseURL: AppConfiguration.baseURL)
        let sessionManager = DefaultNetworkSessionManager(session: SharedURLSession.shared)
        let networkManager = DefaultNetworkManager(networkConfig: networkConfig, sessionManager: sessionManager)
        return DefaultDataTransferService(networkManager: networkManager)
    }()
    
    lazy var homeView: HomeView = {
        let articlesModule = ArticlesModule(apiDataTransferService: apiDataTransferService)
        return articlesModule.generateHomeView()
    }()
}
