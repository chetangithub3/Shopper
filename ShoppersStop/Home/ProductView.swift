//
//  ProductView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    let product: Product
    
    var body: some View {
        NavigationLink {
            ProductDetailView(product: product).environmentObject(cartViewModel)
        } label: {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottomLeading){
                    if let thumbnailURL = product.thumbnail {
                        ImageView(imageURLString: thumbnailURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getScreenBounds().width / 2.3, height: getScreenBounds().width / 2)
                            .clipped()
                           
                    }
                    HStack(alignment: .bottom){
                        VStack{
                            Text(product.title)
                            .font(.subheadline)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .lineLimit(2, reservesSpace: true)
                            .minimumScaleFactor(0.4)
                        }
                         Spacer()
                            Text("$\(product.price)")
                            .font(.subheadline)
                    }
                   
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.orange.gradient)
                    
                }
            }.frame(width: getScreenBounds().width / 2.3 , height: getScreenBounds().width / 2,  alignment: .leading)
                .clipped()
                .cornerRadius(8)
                .shadow(radius: 2)
        }
    }
}


