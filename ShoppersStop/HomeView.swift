//
//  HomeView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @State var products: [Product] = []
    @StateObject var viewModel = ShoppingViewModel()
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                    ForEach(viewModel.products, id: \.id) { product in
                        ProductItemView(product: product)
                    }
                }
                .padding()
            }.navigationTitle("Shopper's Stop")
                .task {
                    await viewModel.getProducts()
                }
            
        }
    }
    
  
}

//#Preview {
//    HomeView()
//}

struct ProductItemView: View {
    let product: Product
    
    var body: some View {
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
        .onAppear(perform: {
          
        })
    }
}
extension View {
    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
