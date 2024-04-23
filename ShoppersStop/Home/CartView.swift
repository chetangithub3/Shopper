//
//  CartView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        VStack{
            if !viewModel.cartItems.isEmpty {
                ScrollView{
                    ForEach(viewModel.cartItems.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { (key, value) in
                        CartItem(cartItem: (key,value))
                    }
                }
                HStack {
                    Text("Total: \(viewModel.totalPrice)")
                }
               
            } else {
                Text("Cart is empty")
            }
        }.navigationTitle("Your Cart")
    }
}

struct CartItem: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var count = 1
    
    var cartItem: (Product, Int)
    init(cartItem: (Product, Int)) {
        self.cartItem = cartItem
        _count = State(initialValue: cartItem.1)
        
    }
    var body: some View {
        VStack{
            HStack{
                Text(cartItem.0.title)
                
            }
            Stepper(value: $count, in: 0...10) {
                Text("Quantity: \(count)")
            }.onChange(of: count) { oldValue, newValue in
                if newValue == 0 {
                    cartViewModel.removeProduct(product: cartItem.0)
                } else {
                    cartViewModel.updateQuantity(product: cartItem.0, quantity: count)
                }
            }
        }
    }
}

#Preview {
    CartView()
}
