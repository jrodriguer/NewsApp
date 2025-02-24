//
//  SharedURLSessionDelegate.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 19/10/24.
//

import Foundation

final class SharedURLSessionDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        challenge.trustServer { challangeDisposition, credential in
            completionHandler(challangeDisposition,credential)
        }
    }
}
