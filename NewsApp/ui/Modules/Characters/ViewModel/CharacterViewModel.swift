//
//  CharacterViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/24.
//

import Foundation
import Alamofire

class CharacterViewModel: ObservableObject {
    // TODO: Wrapper Api protocol with @Inject.
    private var backendApi: BackendApi?
    @Published var characters: [CharacterApiObject] = []
    @Published var locationData: Any = {}
    @Published var isLoading: Bool = false

    init(backendApi: BackendApi = BackendApi(apiUrl: "https://rickandmortyapi.com")) {
        self.backendApi = backendApi
        self.loadCharacters()
    }
    
    func loadCharacters() {
        self.isLoading = true

        backendApi?.getCharacters()?.responseDecodable(of: CharacterListApiObject.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let apiResponse):
                self.characters = apiResponse.results
            case .failure(let error):
                print("Error: \(String(describing: error))")
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(responseString)")
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
        }
    }

    func getLocationData(id: Int) {
        backendApi?.getLocation(id: id)?
            .responseDecodable(of: Location.self) { response in
                switch response.result {
                case .success(let data):
                    self.locationData = data
                case .failure(let error):
                    print("Error fetching location data:", error)
                }
            }
    }
}
