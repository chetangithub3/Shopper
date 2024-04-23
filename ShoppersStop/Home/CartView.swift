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
               
                ForEach(viewModel.cartItems.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { (key, value) in
                    Text("\(key.title): \(value)")
                            }
            } else {
                Text("Cart is empty")
            }
        }.navigationTitle("Your Cart")
    }
}

#Preview {
    CartView()
}
