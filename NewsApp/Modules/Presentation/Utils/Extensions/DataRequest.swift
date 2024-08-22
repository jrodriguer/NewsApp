//
//  DataRequest.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 13/2/24.
//

import Alamofire

extension DataRequest {
    func customValidate() -> Self {
        return self.validate { request, response, data -> Request.ValidationResult in
            let statusCode = response.statusCode
            if statusCode != 401 {
                return .success(())
            } else {
                return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode)))
            }
        }
    }
}
