//
//  SharedURLSession.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//

import Foundation

final class SharedURLSession {
    
    /// This allows you to customize how the session behaves,
    /// especially for tasks like authentication or retry logic.
    static var shared: URLSession {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedURLSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
