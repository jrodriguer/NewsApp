//
//  Favorites.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/1/24.
//

import SwiftUI

class Favorites: ObservableObject {
    private var articles: Set<UUID>

    // The key we're using to read/write
    private let saveKey = "Favorites"

    init() {
        // TODO: Load our saved data

        articles = []
    }

    func contains(_ article: Article) -> Bool {
        articles.contains(article.id)
    }

    func add(_ article: Article) {
        objectWillChange.send()
        articles.insert(article.id)
        save()
    }

    func remove(_ article: Article) {
        objectWillChange.send()
        articles.remove(article.id)
        save()
    }

    func save() {
        // TODO: Write out our data
    }
}
