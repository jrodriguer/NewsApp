//
//  CharacterViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation
import Alamofire

class CharacterViewModel: ObservableObject {
    private var backendApi: ApiRestManager
    @Published var characters: [CharacterApiObject] = []
    
    init(backendApi: BackendApi = BackendApi(apiUrl: "rickandmortyapi.com")) {
        self.backendApi = backendApi
        self.loadCharacters()
    }
    
    func loadCharacters() {
        //
    }
}
