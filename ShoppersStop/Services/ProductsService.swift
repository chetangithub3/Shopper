//
//  ProductsService.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ProductsService {
    @Environment(\.modelContext)
    var modelContext
    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: Product.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()

    @MainActor
    func fetchProducts() -> [Product] {
        do {
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<Product>())
            return data
        } catch {
            return []
        }
    }
}
