//
//  ArticleSearchViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 17/2/25.
//

import Foundation

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    private init() { }

}
