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
                
                NavigationLink {
                    CouponListView().environmentObject(viewModel)
                } label: {
                        HStack {
                            if let couponApplied = viewModel.selectedCoupon {
                                Spacer()
                                Text("'\(couponApplied.name)' applied")
                                    .bold()
                                    .padding()
                                Spacer()
                            } else {
                                Text("Apply coupon").bold()
                                    .padding(.horizontal)
                                Spacer()
                                VStack{
                                    Image(systemName: "arrow.right")
                                         .resizable()
                                         
                                         .foregroundColor(.black)
                                         .frame(width: 25, height: 25)
                                         .padding()
                                         .cornerRadius(8)
                                         .border(.black, width: 2)
                                }.background(Color.white)
                                    .buttonBorderShape(.capsule)
                                    .border(.black, width: 4)
                            }
                          
                          
                        }
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(8)
                    
                }.padding()

              

                if let selectedCoupon = viewModel.selectedCoupon {
                HStack {
                    Text("Cart total: ")
                    Spacer()
                    Text("\(viewModel.cartTotal)")
                }.padding(.vertical)
                    HStack {
                        Text("Coupon applied: ")
                        Spacer()
                        Text("-\(viewModel.discountedAmount)")
                    }.padding(.vertical)
                }
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("\(viewModel.totalPrice)")
                }.padding(.vertical)
            } else {
                Text("Cart is empty")
            }
        }.navigationTitle("Your Cart")
    }
}
extension NumberFormatter {
    static var twoDecimalPlaces: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
struct CartItem: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var count = 1
    var totalCost : Int {
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
            VStack(alignment: .leading, spacing: 10){
                Text(cartItem.0.title)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .bold()
                Text(cartItem.0.category.capitalized)
                    .font(.caption)
                   
            }
                
            Spacer()
            VStack(alignment: .trailing){
                Text("$\(totalCost)")
                    .foregroundStyle(.white)
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
            }.padding()
        }.background(Color.orange.opacity(0.7).gradient)
            .cornerRadius(10)
            .padding([.horizontal, .top])
           
    }
}

#Preview {
    CartView()
}
