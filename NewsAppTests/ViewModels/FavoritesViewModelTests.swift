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
    
}
