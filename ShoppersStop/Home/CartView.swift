//
//  CartView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: CartViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var checkout = false
    
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
                }.padding([.bottom, .horizontal])

                if viewModel.selectedCoupon != nil {
                    VStack(spacing: 12){
                        HStack {
                            Text("Cart total: ")
                            Spacer()
                            Text("\(String(format: "%.2f", viewModel.cartTotal))")
                        }
                        HStack {
                            Text("Coupon applied: ")
                            Spacer()
                            Text("-\(String(format: "%.2f", viewModel.discountedAmount))")
                        }.foregroundColor(.orange)
                        Divider()
                    }.padding()
                }
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("\(String(format: "%.2f", viewModel.totalPrice))")
                }.padding([.horizontal, .bottom])
                    .bold()
                Button(action: {
                    checkout.toggle()
                }) {
                    Text("Checkout")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $checkout) {
                    Alert(title: Text("Checkout complete"), message: Text("Please shop again :)"), dismissButton: .destructive(Text("ok"), action: {
                        viewModel.checkoutCart()
                        presentationMode.wrappedValue.dismiss()
                    }) )
                }
            } else {
                Text("Cart is empty")
            }
        }.navigationTitle("Your Cart")
            .navigationBarItems(trailing: Text("^[\(viewModel.totalNumberOfItems) Item](inflect: true)").foregroundStyle(.orange))
    }
    
    
}

