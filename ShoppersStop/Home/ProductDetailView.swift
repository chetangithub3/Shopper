//
//  ProductDetailView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var body: some View {
        ScrollView(.vertical){
            Text(product.title)
                .font(.title)
            
            if let images = product.images{
                ScrollView(.horizontal) {
//                    ForEach(images, id: \.self) { image in
//                        ImageView(imageURLString: image)
//                            .scaledToFill()
//                            .frame(width: 400, height: 400)
//                        
//                    }
                    

                }
            }
            
           
        }
//        .onAppear(perform: {
//                print(product.id)
//                print(product.category)
//                print(product.title)
//                print(product.desc)
//                print(product.price)
//            print("thumbnail")
//                print(product.thumbnail)
//            print("images")
//            if let images = product.images{
//                print(images)
//            }
//        })
    }
}




