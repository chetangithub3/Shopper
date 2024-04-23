//
//  CartViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import Foundation

class CartViewModel: ObservableObject {
    
    @Published var cartItems: [Product : Int] = [:] {
        didSet {
            calculateTotalCost()
            calculateTotalNumberOfItems()
        }
    }
    @Published var totalPrice: Double = 0.0
    @Published var totalNumberOfItems: Int = 0
    
    func addToCart(product: Product){
        cartItems[product] = 1
       
    }
    
    func updateQuantity(product: Product, quantity: Int) {
        cartItems[product] = quantity
      
    }
    
    func removeProduct(product: Product) {
        cartItems.removeValue(forKey: product)
        
    }
    
    func calculateTotalCost() {
        var totalCost = 0
        for cartItem in cartItems {
            let quantity = cartItem.value
            let costPerEach = cartItem.key.price
            totalCost += costPerEach * quantity
        }
        self.totalPrice = Double(totalCost)
    }
    
    func calculateTotalNumberOfItems() {
       let values =  cartItems.values
      //  values.reduce
    }
    
    
}
