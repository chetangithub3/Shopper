//
//  ShoppingViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation
@MainActor
class ShoppingViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    var productService = ProductsService()
    
    func getProducts() async {
        Task{
            let products = await productService.fetchProducts()
            self.products = products
        }
    }
    
}
