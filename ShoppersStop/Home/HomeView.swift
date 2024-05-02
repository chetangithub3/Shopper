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
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.vertical) {
                    LazyVGrid(
                        columns: [GridItem(.flexible(),
                                           spacing: 16), GridItem(.flexible(), spacing: 16)],
                        spacing: 16) {
                        ForEach(viewModel.filteredProducts, id: \.id) { product in
                            ProductView(product: product).environmentObject(cartViewModel)
                        }
                    }
                    .padding()
                }.navigationTitle("Shopper's Stop")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: CategoryPicker().environmentObject(viewModel))
                    .navigationBarItems(trailing: CartButton().environmentObject(cartViewModel))
                    .task {
                         viewModel.getProducts()
                    }
            }
        }
    }
}

struct CategoryPicker: View {
    @EnvironmentObject var viewModel: ShoppingViewModel
    var body: some View {
        Menu {
            ForEach(ProductCategory.allCases, id: \.self) { category in
                Button(action: {
                    viewModel.selectedCategory = category
                }, label: {
                    HStack {
                        Text(category.rawValue.capitalized).foregroundColor(.orange)
                        if category == viewModel.selectedCategory {
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle").foregroundColor(.orange)
        }
    }
}
