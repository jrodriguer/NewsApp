//
//  FavoritesViewModelTests.swift
//  NewsAppTests
//
//  Created by Julio Rodriguez on 9/7/24.
//

import XCTest

@testable import NewsApp

struct MockItem: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
}

final class FavoritesViewModelTests: XCTestCase {
    var setup: MockDependencies!
    var vm: FavoritesViewModel<MockItem>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        vm = FavoritesViewModel<MockItem>(saveKey:  FavoriteKey.articleFavorites)
    }

    override func tearDownWithError() throws {
        vm = nil
        try super.tearDownWithError()
    }
    
    func testInitialization() {
        XCTAssertTrue(vm.filtered(from: [], showFavoritesOnly: true).isEmpty)
    }
    
    func testAddFavorite() {
        let item = MockItem(id: UUID(), name: "Test Item")
        vm.add(item)
        XCTAssertTrue(vm.contains(item))
        XCTAssertEqual(vm.filtered(from: [item], showFavoritesOnly: true).count, 1)
    }
    
    func testRemoveFavorite() {
        let item = MockItem(id: UUID(), name: "Test Item")
        vm.add(item)
        XCTAssertTrue(vm.contains(item))
        vm.remove(item)
        XCTAssertFalse(vm.contains(item))
        XCTAssertTrue(vm.filtered(from: [item], showFavoritesOnly: true).isEmpty)
    }
    
    func testFilterFavorites() {
        let item1 = MockItem(id: UUID(), name: "Item 1")
        let item2 = MockItem(id: UUID(), name: "Item 2")
        vm.add(item1)
        let allItems = [item1, item2]
        XCTAssertEqual(vm.filtered(from: allItems, showFavoritesOnly: true), [item1])
        XCTAssertEqual(vm.filtered(from: allItems, showFavoritesOnly: false), allItems)
    }
}
