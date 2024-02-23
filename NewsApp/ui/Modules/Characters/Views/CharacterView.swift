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
    @State private var messages = [Message]()
    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.characters.filter { character in
                        searchText.isEmpty || character.name.contains(searchText)
                    }) { character in
                        ZStack(alignment: .leading) {
                            Text(character.name)
                            NavigationLink(destination: 
                                            CharacterDetailView(character: character)
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
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { runSearch() }
        
    }
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // TODO: Making an asynchronous network request.
    // FIXME:  Integrate the Rick & Morty API filtering, GET https://rickandmortyapi.com/api/character/?name=rick&status=alive
    
    func runSearch() {
        
        // TODO: Run this filter API call when submit filter form options.
        
        Task {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            var queryItems: [URLQueryItem] = []
            
            if !searchText.isEmpty {
                queryItems.append(URLQueryItem(name: "name", value: searchText))
            }
            
            // Add more query parameters as needed (e.g., status, species, type, gender)
            // Example: queryItems.append(URLQueryItem(name: "status", value: "alive"))

            components?.queryItems = queryItems
            
            print("Query items for this call: \(queryItems)")
            
            if let filteredURL = components?.url {
                let (data, _) = try await URLSession.shared.data(from: filteredURL)
                do {
                    let characters = try JSONDecoder().decode([CharacterApiObject].self, from: data)
                    // Update your view model or data source with the filtered characters
                    vm.characters = characters
                } catch {
                    print("Error decoding characters: \(error)")
                }
            }
        }
    }
}

#Preview {
    CharacterView()
}
