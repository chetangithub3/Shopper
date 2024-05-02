//
//  ShoppingViewModelTests.swift
//  ShoppersStopTests
//
//  Created by Chetan Dhowlaghar on 4/30/24.
//

import XCTest

final class ShoppingViewModelTests: XCTestCase {
    @MainActor
    func testFetchProducts() {
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

    @MainActor
    func testFilterProducts() {
        let viewModel = ShoppingViewModel()
            // Set up initial products
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
        let product3 = Product(
            id: 2,
            category: "smartphones",
            title: "Product 3",
            desc: "",
            price: 24,
            thumbnail: nil,
            images: nil
        )
        viewModel.allProducts = [
            product1,
            product2,
            product3
        ]
            // Test filtering when selectedCategory is .all
        viewModel.selectedCategory = .all
        XCTAssertEqual(viewModel.filteredProducts.count, 3) // All products should be included
        viewModel.selectedCategory = .smartphones
        XCTAssertTrue(viewModel.filteredProducts.contains(product3))
        XCTAssertFalse(viewModel.filteredProducts.contains(product2))
    }

    @MainActor
    func testSelectedCategoryUpdate() {
        let viewModel = ShoppingViewModel()
            // Set up initial products
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
        let product3 = Product(
            id: 2,
            category: "smartphones",
            title: "Product 3",
            desc: "",
            price: 24,
            thumbnail: nil,
            images: nil
        )
        viewModel.allProducts = [
            product1,
            product2,
            product3
        ]
            // Set the selectedCategory and verify that filteredProducts are updated
        viewModel.selectedCategory = .fragrances
        XCTAssertEqual(viewModel.filteredProducts.count, 1)
            // Update selectedCategory again and verify the change
        viewModel.selectedCategory = .smartphones
        XCTAssertEqual(viewModel.filteredProducts.count, 2)
    }

    @MainActor
    func testDefaultCategoryFilterWithEmptyProductList() {
        let viewModel = ShoppingViewModel()
        viewModel.allProducts = [] // Empty product list
        viewModel.selectedCategory = .all
        viewModel.filterProducts()
        XCTAssertTrue(viewModel.filteredProducts.isEmpty)
    }
}
