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
            VStack(alignment: .leading){
                Text(product.title)
                    .font(.title)
              
                if let thumbnail = product.thumbnail{
                    ImageView(imageURLString: thumbnail)
                        .scaledToFill()
                        .frame(width: getScreenBounds().width - 40, height: getScreenBounds().width - 40)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                HStack{
                    Text("Price: \(product.price)")
                    Spacer()
                    if showStepper{
                        Stepper(value: $count, in: 0...10) {
                            Text("\(count)")
                        }.onChange(of: count) { oldValue, newValue in
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
                                
                        }).buttonBorderShape(.capsule)
                    }
                }

            }
        }.padding()

    }
}




