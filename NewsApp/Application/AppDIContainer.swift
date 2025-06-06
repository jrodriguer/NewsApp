//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//
//  Description:
//  Initialize global dependencies and creates the entry point of the app.

import Foundation

final class AppDIContainer {
    
    lazy var apiDataTransferService: DataTransferService = {
        let networkConfig = ApiDataNetworkConfig(baseURL: AppConfiguration.baseURL)
        let sessionManager = DefaultNetworkSessionManager(session: SharedURLSession.shared)
        let networkManager = DefaultNetworkManager(networkConfig: networkConfig, sessionManager: sessionManager)
        return DefaultDataTransferService(networkManager: networkManager)
    }()
    
    lazy var tabsView: ContentView = {
        let articlesModule = ArticlesModule(apiDataTransferService: apiDataTransferService)
        return articlesModule.generateContentView()
    }()
}
