//
//  CharacterView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 14/2/24.
//

// CharacterView.swift

import SwiftUI

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct CharacterView: View {
    @StateObject var vm = CharacterViewModel()
    @State var favorites = CharacterFavoritesViewModel()
    @State private var messages = [Message]()
    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox
    @State private var showFavoritesOnly = false
    
    var filteredCharacters: [CharacterApiObject] {
        let allCharacters = vm.characters
        switch searchScope {
        case .inbox:
            return favorites.filteredCharacters(from: allCharacters, showFavoritesOnly: showFavoritesOnly)
                .filter { character in
                    searchText.isEmpty || character.name.localizedCaseInsensitiveContains(searchText)
                }
        case .favorites:
            return allCharacters.filter { character in
                favorites.contains(character) && (searchText.isEmpty || character.name.localizedCaseInsensitiveContains(searchText))
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(filteredCharacters) { character in
                        ZStack(alignment: .leading) {
                            Text(character.name)
                            NavigationLink(destination:
                                            CharacterDetailView(character: character)
                                .environmentObject(vm)
                                .environmentObject(favorites)
                            ) {
                                EmptyView()
                            }
                            .opacity(0.0)
                        }
                    }
                }
                .navigationBarTitle("Characters")
            }
        }
        .searchable(text: $searchText)
        .searchScopes($searchScope) {
            // TODO: Add the logic for handling these scopes.
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
            }
        }
        // TODO: Performs a search based on the current search scope.
        .onChange(of: searchScope, runSearch)
        // TODO: Making an asynchronous network request: .onSubmit(of: .search, runSearch)
        //! TODO: Infine scroll.
    }
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func runSearch() {
        
        // TODO: Run this filter API call when submit filter form options.
        
        Task {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            var queryItems: [URLQueryItem] = []
            
            if !searchText.isEmpty {
                queryItems.append(URLQueryItem(name: "name", value: searchText))
            }
            components?.queryItems = queryItems
            
            print("Query items for this call: \(queryItems)")
            
            if let filteredURL = components?.url {
                do {
                    let (data, _) = try await URLSession.shared.data(from: filteredURL)
                    print("API Response Data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    if let dictionaryResponse = try? decoder.decode([String: CharacterApiObject].self, from: data) {
                        /// Handle dictionary response
                        let characters = Array(dictionaryResponse.values)
                        /// Update view model with the filtered characters.
                        vm.characters = characters
                    } else {
                        /// Handle array response
                        let characters = try decoder.decode([CharacterApiObject].self, from: data)
                        /// Update view model with the filtered characters.
                        vm.characters = characters
                    }
                } catch {
                    // FIXME: typeMismatch(Swift.Array<Any>, Swift.DecodingError.Context(codingPath: [], debugDescription: "Expected to decode Array<Any> but found a dictionary instead.", underlyingError: nil))
                    print("Error decoding characters: \(error)")
                }
            }
        }
    }
}

#Preview {
    CharacterView()
}
