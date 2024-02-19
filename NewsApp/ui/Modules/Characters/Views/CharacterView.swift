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

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    List {
                        ForEach(vm.characters) { character in
                            Button(action: {
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
        }
    }
}

#Preview {
    CharacterView()
}
