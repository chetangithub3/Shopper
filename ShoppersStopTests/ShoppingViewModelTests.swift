//
//  ShoppingViewModelTests.swift
//  ShoppersStopTests
//
//  Created by Chetan Dhowlaghar on 4/30/24.
//

import XCTest

final class ShoppingViewModelTests: XCTestCase {

    @MainActor func testFetchProducts() {
        let shoppingVM = ShoppingViewModel()
        let product1 = Product(
            id: 1,
            category: "smartphones",
            title: "Product 1",
            desc: "",
            price: 10,
            thumbnail: nil,
            images: nil
        )
        let product2 = Product(
            id: 2,
            category: "fragrances",
            title: "Product 2",
            desc: "",
            price: 20,
            thumbnail: nil,
            images: nil
        )
        shoppingVM.allProducts = [product1, product2]
        shoppingVM.selectedCategory = .fragrances
        XCTAssert(shoppingVM.filteredProducts.count == 1)
    }
}
