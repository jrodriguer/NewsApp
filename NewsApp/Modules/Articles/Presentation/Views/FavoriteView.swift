//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/25.
//

import SwiftUI

struct FavoriteView<ViewModel>: View where ViewModel: FavoritesViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
