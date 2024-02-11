//
//  CharacterViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation
import Alamofire

class CharacterViewModel: ObservableObject {
    private var apiRest: ApiRestManager
    @Published var characters: [CharacterApiObject] = []
    
    init(apiRest: ApiRestManager = ApiRestManager()) {
        self.apiRest = apiRest
        self.loadCharacters()
    }
    
    func loadCharacters() {
        //
    }
}
