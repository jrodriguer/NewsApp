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
                            NavigationLink(destination: Text(character.name)
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
            }
        }
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
    
    // TODO: Add my own logic.
    
    func runSearch() {
        Task {
            guard let url = URL(string: "https://hws.dev/\(searchScope.rawValue).json") else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        }
    }
}

#Preview {
    CharacterView()
}
