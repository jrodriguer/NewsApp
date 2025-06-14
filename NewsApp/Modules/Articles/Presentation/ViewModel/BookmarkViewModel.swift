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
    var bookmarks: [ArticleUIModel] { get set }
    func loadBookmarks() -> [ArticleUIModel]
    func contains(_ value: ArticleUIModel) -> Bool
    func add(_ value: ArticleUIModel)
    func remove(_ value: ArticleUIModel)
    func filtered(from allItems: [ArticleUIModel], showFavoritesOnly: Bool) -> [ArticleUIModel]
}

class BookmarkViewModel: BookmarkViewModelProtocol {
    
    @Published var bookmarks: [ArticleUIModel] = []
    
    private var saveKey: BookmarkKey
    private var userDefaultsManager: any UserDefaultsServiceProtocol.Type
    
    init(saveKey: BookmarkKey, userDefaultsManager: any UserDefaultsServiceProtocol.Type = UserDefaultsService.self) {
        self.saveKey = saveKey
        self.userDefaultsManager = userDefaultsManager
        self.bookmarks = loadBookmarks()
    }
    
    func loadBookmarks() -> [ArticleUIModel] {
        if let storedItems = UserDefaultsService.getItem(saveKey) as [ArticleUIModel]? {
            bookmarks = storedItems
            return bookmarks
        } else {
            return []
        }
    }
    
    private func saveBookmarks() {
        do {
            let encoded = try JSONEncoder().encode(bookmarks)
            UserDefaultsService.saveItem(saveKey, encoded)
            Log.debug(tag: BookmarkViewModel.self, message: "Bookmarks saved")
        } catch {
            print("Error encoding value \(error)")
        }
    }
    
    func contains(_ value: ArticleUIModel) -> Bool {
        return bookmarks.contains { $0.id == value.id }
    }
    
    func add(_ value: ArticleUIModel) {
        objectWillChange.send()
        bookmarks.append(value)
        Log.debug(tag: BookmarkViewModel.self, message: "Bookmarks updated")
        saveBookmarks()
    }
    
    func remove(_ value: ArticleUIModel) {
        objectWillChange.send()
        bookmarks.removeAll(where: { $0.id == value.id })
        saveBookmarks()
    }
    
    func toggle(_ value: ArticleUIModel) {
        if contains(value) {
            remove(value)
        } else {
            add(value)
        }
    }
    
    func filtered(from allItems: [ArticleUIModel], showFavoritesOnly: Bool) -> [ArticleUIModel] {
        return showFavoritesOnly ? allItems.filter { contains($0) } : allItems
    }
}
