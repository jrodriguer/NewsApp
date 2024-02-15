//
//  CharacterView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 14/2/24.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var vm = CharacterViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    if !vm.characters.isEmpty {
                        ForEach(vm.characters) { character in
                            VStack(alignment: .leading) {
                                // TODO: Add character name row.
                                Text(character.name)
                            }
                        }
                    } else {
                        Text("No characters available")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .navigationBarTitle("Characters")
                .onAppear {
                    vm.loadCharacters()
                }
            }
        }
    }
}

#Preview {
    CharacterView()
}
