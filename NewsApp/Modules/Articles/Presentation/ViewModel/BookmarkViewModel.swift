//
//  BookmarkViewModel.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 27/2/24.
//

import Foundation

enum BookmarkKey: String {
    case articleBookmarks
}

protocol BookmarkViewModelProtocol: ObservableObject {
    var bookmarks: [ArticleListItemViewModel] { get set }
    func loadBookmarks() -> [ArticleListItemViewModel]
    func contains(_ value: ArticleListItemViewModel) -> Bool
    func add(_ value: ArticleListItemViewModel)
    func remove(_ value: ArticleListItemViewModel)
    func filtered(from allItems: [ArticleListItemViewModel], showFavoritesOnly: Bool) -> [ArticleListItemViewModel]
}

class BookmarkViewModel: BookmarkViewModelProtocol {
    
    @Published var bookmarks: [ArticleListItemViewModel] = []
    
    private var saveKey: BookmarkKey
    private var userDefaultsManager: any UserDefaultsServiceProtocol.Type
    
    init(saveKey: BookmarkKey, userDefaultsManager: any UserDefaultsServiceProtocol.Type = UserDefaultsService<ArticleListItemViewModel>.self) {
        self.saveKey = saveKey
        self.userDefaultsManager = userDefaultsManager
        self.bookmarks = loadBookmarks()
    }
    
    func loadBookmarks() -> [ArticleListItemViewModel] {
        if let storedItems = UserDefaultsService<[ArticleListItemViewModel]>.getItem(saveKey),
           let decodedItems = try? JSONDecoder().decode([ArticleListItemViewModel].self, from: storedItems) {
            bookmarks = decodedItems
            return bookmarks
        } else {
            return []
        }
    }
    
    private func saveBookmarks() {
        do {
            let encoded = try JSONEncoder().encode(bookmarks)
            UserDefaultsService<ArticleListItemViewModel>.saveItem(saveKey, encoded)
            Log.debug(tag: BookmarkViewModel.self, message: "Bookmarks saved")
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func contains(_ value: ArticleListItemViewModel) -> Bool {
        return bookmarks.contains { $0.id == value.id }
    }
    
    func add(_ value: ArticleListItemViewModel) {
        objectWillChange.send()
        bookmarks.append(value)
        Log.debug(tag: BookmarkViewModel.self, message: "Bookmarks updated")
        saveBookmarks()
    }
    
    func remove(_ value: ArticleListItemViewModel) {
        objectWillChange.send()
        bookmarks.removeAll(where: { $0.id == value.id })
        saveBookmarks()
    }
    
    func toggle(_ value: ArticleListItemViewModel) {
        if contains(value) {
            remove(value)
        } else {
            add(value)
        }
    }
    
    func filtered(from allItems: [ArticleListItemViewModel], showFavoritesOnly: Bool) -> [ArticleListItemViewModel] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
