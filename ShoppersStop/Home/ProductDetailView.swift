//
//  ProductDetailView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.presentationMode) var presentationMode
    var product: Product
    
    @State var showStepper = false
    @State var count = 1
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 0){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let thumbnail = product.thumbnail{
                                ImageView(imageURLString: thumbnail)
                                    .scaledToFill()
                                    .frame(width: getScreenBounds().width - 40, height: getScreenBounds().width - 100)
                                    .cornerRadius(10)
                            }
                            if let images = product.images {
                                ForEach(images, id: \.self) { image in
                                    ImageView(imageURLString: image)
                                        .scaledToFill()
                                        .frame(width: getScreenBounds().width - 40, height: getScreenBounds().width - 100)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(16, for: .automatic)
                    .listRowInsets(EdgeInsets())
                    HStack{
                        Text(product.title)
                            .font(.title3)
                        Spacer()
                        Text("$\(product.price)")
                            .font(.subheadline)
                    }.padding(.horizontal)
                        .bold()
                }
                Text(product.desc)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .padding(.bottom, 40)
            }
            if showStepper{
                HStack{
                    Spacer()
                    CartStepper(itemCount: $count, range: 0...10)
                        .onChange(of: count) { oldValue, newValue in
                            if newValue == 0 {
                                showStepper = false
                                cartViewModel.removeProduct(product: product)
                            } else {
                                cartViewModel.updateQuantity(product: product, quantity: count)
                            }
                        }
                    Spacer()
                } .padding()
                    .bold()
                    .font(.title3)
                    .background(Color.orange.gradient)
                    .foregroundColor(.white)
            } else {
                Button(action: {
                    cartViewModel.addToCart(product: product)
                    showStepper.toggle()
                }, label: {
                    HStack{
                        Spacer()
                        Text("Add to cart")
                        Spacer()
                    }
                    .padding()
                    .bold()
                    .font(.title3)
                    .background(Color.orange.gradient)
                    .foregroundColor(.white)
                })
            }
        })
        .onChange(of: cartViewModel.checkout, { oldValue, newValue in
            if newValue {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: CartButton().environmentObject(cartViewModel))
    }
}



