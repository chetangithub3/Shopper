//
//  ProductDetailView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    var product: Product
    @State var showStepper = false
    @State var count = 1
    var body: some View {
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
                    Spacer()
                    Text("$\(product.price)")
                } .font(.title3)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
            }.background(Color.orange.gradient)
            
            if showStepper{
                CartStepper(itemCount: $count, range: 0...10)
                .onChange(of: count) { oldValue, newValue in
                    if newValue == 0 {
                        showStepper = false
                        cartViewModel.removeProduct(product: product)
                    } else {
                        cartViewModel.updateQuantity(product: product, quantity: count)
                    }
                }
               
            } else {
                Button(action: {
                    cartViewModel.addToCart(product: product)
                    showStepper.toggle()
                }, label: {
                    Text("Add to cart")
                        .bold()
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                })
            }
        }
           
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                    CartButton().environmentObject(cartViewModel)
                )
                

    }
}




struct CartStepper: View {
    @Binding var itemCount: Int
    let range: ClosedRange<Int>

    var body: some View {
        HStack {
            Button(action: {
                if self.itemCount > self.range.lowerBound {
                    self.itemCount -= 1
                }
            }) {
                Image(systemName: "minus")
            }
            .foregroundColor(self.itemCount > self.range.lowerBound ? .orange : .gray)
            
            Text("\(itemCount)")
                .bold()
            
            Button(action: {
                if self.itemCount < self.range.upperBound {
                    self.itemCount += 1
                }
            }) {
                Image(systemName: "plus")
            }
            .foregroundColor(self.itemCount < self.range.upperBound ? .orange : .gray)
        }
    }
}
