//
//  NetworkService.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation
import Alamofire

struct Endpoint {
    let url: URLConvertible
    let method: HTTPMethod
    let parameters: Parameters?

    init(url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
    }
}

class NetworkService {
    static let shared = NetworkService()

    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
