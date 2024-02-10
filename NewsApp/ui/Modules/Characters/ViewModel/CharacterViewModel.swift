//
//  CharacterViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation

class CharacterViewModel: ObservableObject {
    private var apiRest: ApiRestManager
    
    init(apiRest: ApiRestManager = ApiRestManager()) {
        self.apiRest = apiRest
    }
}
