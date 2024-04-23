//
//  ContentView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    @State var isDone: Bool = false
    @ObservedObject var viewModel = OnboardingViewModel()
    @Environment(\.modelContext) var modelContext
    var body: some View {
        VStack{
            headingView
               
            descriptionView
            
            if isDone {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .opacity(isDone ? 1 : 0)
                        .scaleEffect(isDone ? 1 : 0.1)
                        .animation(.spring())
                })
            } else {
                HStack{
                    ProgressView()
                    Text("Fetching products...")
                }
               
            }
        }
        .padding()
        .onAppear(perform: {
        
            Task {
                let fetchedProducts = try await viewModel.fetchProducts()
                if let products = fetchedProducts{
                    await saveProducts(products)
                }
            }
        })
        
        
    
    }
    
    func saveProducts(_ products: ProductsModel) async {
        Task {
            for product in products.products {
                try? await saveProduct(product)
            }
                // delay introduced to show transition animation
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            enableGetStarted()
        }
    }
    
    func saveProduct(_ product: ProductModel) async throws {
        if let title = product.title,
           let id = product.id,
           let description = product.description,
           let price = product.price,
           let category = product.category,
           let thumbnail = product.thumbnail,
           let images = product.images {
            let databaseProduct = Product(id: id, category: category, title: title, desc: description, price: price, thumbnail: thumbnail, images: images)
            modelContext.insert(databaseProduct)
        }
           
           
    }
    
  @MainActor
    func enableGetStarted() {
        isOnboardingDone = true
        withAnimation {
            isDone = true
        }
     
    }
    var headingView: some View {
        HStack {
            Image(systemName: "cart.fill")
                .imageScale(.large)
                .font(.title)
            Text("Shoppers Stop")
                .font(.title)
                .bold()
        }.foregroundStyle(.orange)
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading){
            Text("Welcome to Shoppers Stop!")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            Text("Your one-stop destination for all your shopping needs. Discover trending products in various categories, and enjoy a seamless shopping experience.")
        }.padding()
       

    }
}



