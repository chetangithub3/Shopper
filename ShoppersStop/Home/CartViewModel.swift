//
//  CartViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var cartItems: [Product : Int] = [:]
    @Published var totalPrice: Double = 0.0
    
    func addToCart(product: Product){
        cartItems[product] = 1
    }
    
    func updateQuantity(product: Product, quantity: Int) {
        cartItems[product] = quantity
    }
    
    func removeProduct(product: Product) {
        cartItems.removeValue(forKey: product)
    }
    
}
