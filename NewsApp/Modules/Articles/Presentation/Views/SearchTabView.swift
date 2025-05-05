//
//  SearchTabView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 12/2/25.
//

import SwiftUI

struct SearchTabView<ViewModel>: View where ViewModel: ArticleViewModelProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .navigationTitle("Search")
    }
}
