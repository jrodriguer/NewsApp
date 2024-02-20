//
//  CharacterView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 14/2/24.
//

// CharacterView.swift

import SwiftUI

struct CharacterView: View {
    @StateObject var vm = CharacterViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.characters.filter { character in
                        searchText.isEmpty || character.name.contains(searchText)
                    }) { character in
                        Button(action: {
                            //
                        }) {
                            VStack(alignment: .leading) {
                                Text(character.name)
                            }
                        }
                    }
                }
                .navigationBarTitle("Characters")
                .onAppear {
                    vm.loadCharacters()
                }
            }
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    CharacterView()
}
