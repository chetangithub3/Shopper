//
//  ShoppingViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation

@MainActor
class ShoppingViewModel: ObservableObject {
    var productService = ProductsService()
    @Published var allProducts: [Product] = []
    @Published var selectedCategory: ProductCategory = .all {
        didSet {
            filterProducts()
        }
    }
    @Published var filteredProducts: [Product] = []

    func getProducts() {
        Task {
            let products = productService.fetchProducts()
            self.allProducts = products
            filterProducts()
        }
    }

    func filterProducts() {
        if selectedCategory == .all {
            self.filteredProducts = allProducts
        } else {
            self.filteredProducts = allProducts.filter { $0.category == selectedCategory.rawValue }
        }
    }
}
