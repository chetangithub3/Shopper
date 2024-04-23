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
//            Image(systemName: "photo") // Placeholder image, you can replace this with the actual product image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 150, height: 150)
//                .cornerRadius(8)
            
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
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
