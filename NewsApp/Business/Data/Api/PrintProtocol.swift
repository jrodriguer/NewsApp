//
//  PrintProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 29/2/24.
//

import Foundation

/// A custom protocol for logging outgoing requests.
final class PrintProtocol: URLProtocol {
    
    override public class func canInit(with request: URLRequest) -> Bool {
        print("? Running request: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
        // By returning `false`, this URLProtocol will do nothing less than logging.
        return false
    }
}
