//
//  CartItem.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import SwiftUI

struct CartItem: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var count = 1
    var totalCost: Int {
        return cartItem.0.price * count
    }
    var cartItem: (Product, Int)

    init(cartItem: (Product, Int)) {
        self.cartItem = cartItem
        _count = State(initialValue: cartItem.1)
    }

    var body: some View {
        HStack {
            if let thumbnail = cartItem.0.thumbnail {
                ImageView(imageURLString: thumbnail)
                    .scaledToFill()
                    .frame(width: getScreenBounds().width / 5, height: getScreenBounds().width / 5)
                    .clipped()
                    .cornerRadius(10)
                    .padding(4)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(cartItem.0.title)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .bold()
                Text(cartItem.0.category.capitalized)
                    .font(.caption)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(totalCost)")
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
                CartStepper(itemCount: $count, range: 0...10)
                    .onChange(of: count) { _, newValue in
                        if newValue == 0 {
                            cartViewModel.removeProduct(product: cartItem.0)
                        } else {
                            cartViewModel.updateQuantity(product: cartItem.0, quantity: count)
                        }
                    }
            }.padding()
        }.background(Color.orange.opacity(0.7).gradient)
            .cornerRadius(10)
            .padding([.horizontal, .top])
    }
}
