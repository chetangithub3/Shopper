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
    @StateObject var cartViewModel = CartViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView(.horizontal) {
                    Picker("", selection: $viewModel.selectedCategory) {
                        ForEach(ProductCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                        }
                    } .pickerStyle(.segmented)
                }
                .padding(.horizontal)
               
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(viewModel.filteredProducts, id: \.id) { product in
                            ProductView(product: product)
                        }
                    }
                    .padding()
                }.navigationTitle("Shopper's Stop")
                    .task {
                        await viewModel.getProducts()
                    }
            }
            .overlay {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink {
                            CartView()
                        } label: {
                            Image(systemName: "cart.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .foregroundColor(.orange)
                                )
                                .padding(.horizontal)
                        }
                    }
                }
                

                
            }
           
            
        }
    }
}



//#Preview {
//    HomeView()
//}


extension View {
    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
