//
//  CharacterViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation
import Alamofire

class CharacterViewModel: ObservableObject {
    private var backendApi: BackendApi?
    @Published var characters: [CharacterApiObject] = []
    
    init(backendApi: BackendApi = BackendApi(apiUrl: "https://rickandmortyapi.com")) {
        self.backendApi = backendApi
        self.loadCharacters()
    }
    
    func loadCharacters() {
        backendApi?.getCharacters()?.responseDecodable(of: [CharacterApiObject].self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let characters):
                print("Response: \(characters)")
                self.characters = characters
            case .failure(let error):
                print("Error: \(String(describing: error))")
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(responseString)")
                }
            }
        }
    }
}
