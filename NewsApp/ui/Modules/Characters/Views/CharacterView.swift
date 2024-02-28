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
    @StateObject private var vm = CharacterViewModel()
    @State private var favorites = FavoritesViewModel<CharacterApiObject>()
    @State private var messages = [Message]()
    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox
    @State private var showFavoritesOnly = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResult) { character in
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
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
                    .tag(scope)
            }
        }
    }
    
    private var searchResult: [CharacterApiObject] {
        let allCharacters = vm.characters
        switch searchScope {
        case .inbox:
            return favorites.filtered(from: allCharacters, showFavoritesOnly: showFavoritesOnly)
                .filter { character in
                    searchText.isEmpty || character.name.localizedCaseInsensitiveContains(searchText)
                }
        case .favorites:
            return allCharacters.filter { character in
                favorites.contains(character) && (searchText.isEmpty || character.name.localizedCaseInsensitiveContains(searchText))
            }
        }
    }
    
    private var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    CharacterView()
}
