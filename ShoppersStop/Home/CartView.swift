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
        VStack(spacing: 0){
            if !viewModel.cartItems.isEmpty {
                ScrollView{
                    ForEach(viewModel.cartItems.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { (key, value) in
                        CartItem(cartItem: (key,value))
                    }
                }
                if let couponApplied = viewModel.selectedCoupon {
                    HStack{
                        Text("'\(couponApplied.name)' applied")
                    }
                } else {
                    NavigationLink {
                        CouponListView().environmentObject(viewModel)
                    } label: {
                        HStack {
                            Text("Apply coupons")
                            Spacer()
                            Text("->")
                        }.padding(.vertical)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
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
        
        HStack {
            if let thumbnail = cartItem.0.thumbnail {
                ImageView(imageURLString: thumbnail)
                    .scaledToFill()
                    .frame(width: getScreenBounds().width / 5, height: getScreenBounds().width / 5)
                    .clipped()
                    .cornerRadius(10)
                    .padding(4)
            }
            HStack(alignment: .center){
                Text(cartItem.0.title)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .bold()
                Spacer()
                CartStepper(itemCount: $count, range: 0...10)
                    .onChange(of: count) { oldValue, newValue in
                        if newValue == 0 {
                            cartViewModel.removeProduct(product: cartItem.0)
                        } else {
                            cartViewModel.updateQuantity(product: cartItem.0, quantity: count)
                        }
                }
            }.padding(.horizontal)
               
        }.background(Color.orange.opacity(0.7).gradient)
            .cornerRadius(10)
            .padding([.horizontal, .top])
           
    }
}

#Preview {
    CartView()
}
