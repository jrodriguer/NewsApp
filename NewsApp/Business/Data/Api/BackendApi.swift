//
//  BackendApi.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Foundation
import Alamofire

protocol BackendApiProtocol {
    func getArticles(category: Category?) -> DataRequest?
    /*func getCharacters(page: Int,
                       name: String?,
                       status: StatusEnum?,
                       species: String?,
                       type: String?,
                       gender: GenderEnum?) -> DataRequest?*/
    func getLocations() -> DataRequest?
    func getLocation(id: Int) -> DataRequest?
}

class BackendApi: ApiRestManager, BackendApiProtocol {
    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
        super.init(url: apiUrl, urlProtocols: [PrintProtocol.self])
    }
        
    func getArticles(category: Category?) -> DataRequest? {
        let apiKey = "978764b3fe6b412f8517a7d9c0a1e140"
        var serviceURL: String = "/v2/top-headlines/?country=us&apiKey=\(apiKey)"
        if let category = category {
            serviceURL += "&category=\(category.rawValue)"
        }
        
        let request = get(service: serviceURL)
        
        request.response { response in
            if let error = response.error {
                print("❌ Request failed with error: \(error.localizedDescription)\n")
            } else {
                print("✅ Request completed\n")
            }
        }
        return request
    }
    
    func getCharacters() -> DataRequest? {
        let serviceURL: String = "/api/character"
        return get(service: serviceURL)
    }
    
    /*func getCharacters(page: Int,
                       name: String?,
                       status: StatusEnum?,
                       species: String?,
                       type: String?,
                       gender: GenderEnum?) -> DataRequest? {
        
        var serviceURL: String = "character"
        serviceURL = serviceURL + "?page=\(page)"
        
        let parameterDict: [String: String] = [
            "name" : name ?? "",
            "status" : status?.rawValue ?? "",
            "species" : species ?? "",
            "type" : type ?? "",
            "gender" : gender?.rawValue ?? ""
        ]
        
        for (key, value) in parameterDict {
            if value != "" {
                serviceURL.append("&"+key+"="+value)
            }
        }
        
        return self.get(service: serviceURL)
    }*/
    
    func getLocations() -> DataRequest? {
        let serviceURL: String = "/api/location"
        return get(service: serviceURL)
    }
    
    func getLocation(id: Int) -> DataRequest? {
        let serviceURL: String = "/api/location/\(id)"
        return get(service: serviceURL)
    }
    
    func getEpisodes() -> DataRequest? {
        let serviceURL: String = "/api/episode"
        return get(service: serviceURL)
    }
}
