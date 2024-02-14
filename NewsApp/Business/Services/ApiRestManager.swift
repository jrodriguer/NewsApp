//
//  ApiRestManager.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 6/2/24.
//

import Foundation
import Alamofire

class ApiRestManager {
    private var urlService: String
    private var manager: Session
    
    init(url: String,
         requestRetrier: RequestRetrier? = nil,
         requestAdapter: RequestAdapter? = nil,
         eventMonitor: EventMonitor? = nil,
         urlProtocols: [AnyClass]? = nil) {
        self.urlService = url
        
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            config.protocolClasses = urlProtocols
            return config
        }()
        
        var adapters: [RequestAdapter] = []
        var retriers: [RequestRetrier] = []
        var eventMonitors: [EventMonitor] = []
        
        if let requestAdapter = requestAdapter {
            adapters.append(requestAdapter)
        }
        
        if let requestRetrier = requestRetrier {
            retriers.append(requestRetrier)
        }
        
        if let eventMonitor = eventMonitor {
            eventMonitors.append(eventMonitor)
        }
        
        let interceptor = Interceptor(adapters: adapters,
                                      retriers: retriers)
        
        self.manager = Session(configuration: configuration,
                               interceptor: interceptor,
                               eventMonitors: eventMonitors)
    }
    
    private func getUrlService(_ service: String) -> String {
        return self.urlService + service
    }
    
    private func request(service: String,
                         method: HTTPMethod,
                         parameters: Parameters? = nil,
                         encoding: ParameterEncoding,
                         headers: HTTPHeaders? = nil) -> DataRequest {
        return manager
            .request(getUrlService(service),
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headers)
            .validate(statusCode: 200..<500)
            .customValidate()
    }
    
    internal func get(service: String,
                      parameters: Parameters? = nil,
                      encoding: ParameterEncoding = URLEncoding.queryString,
                      headers: HTTPHeaders? = nil) -> DataRequest {
        
        return request(service: service,
                       method: .get,
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers)
    }
}
