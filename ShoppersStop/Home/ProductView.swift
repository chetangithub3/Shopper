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
                if let thumbnailURL = product.thumbnail {
                    ImageView(imageURLString: thumbnailURL)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getScreenBounds().width / 3, height: getScreenBounds().width / 3)
                    
                        .clipped()
                        .cornerRadius(10)
                }
                Text(product.title)
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("Price: $\(product.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Category: \(product.category)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }.frame(width: getScreenBounds().width / 2.5 , alignment: .leading)
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
        }

        
       
    }
}


