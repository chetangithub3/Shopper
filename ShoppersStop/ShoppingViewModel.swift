//
//  ShoppingViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation

class ShoppingViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    var productService = ProductsService()
    
   @MainActor func getProducts() async {
        Task{
            let products = await productService.fetchProducts()
            for product in products {
                print(product.title)
            }
            self.products = products
        }
         
        
    }
    
    
}
