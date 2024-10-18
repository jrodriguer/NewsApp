//
//  NetworkConfigurable.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 18/10/24.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
}

class ApiDataNetworkConfig: NetworkConfigurable {
    
    let baseURL: URL
    let headers: [String: String]
    
     init(baseURL: URL,
        headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
