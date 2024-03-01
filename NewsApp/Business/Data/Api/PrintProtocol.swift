//
//  PrintProtocol.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 29/2/24.
//

import Foundation

final class PrintProtocol: URLProtocol {
    override public class func canInit(with request: URLRequest) -> Bool {
        print("? Running request: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
        return false
    }
}
