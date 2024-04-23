//
//  Products.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation

    // MARK: - Products
    struct ProductsModel: Codable {
        let products: [ProductModel]
        let total, skip, limit: Int?
    }

    // MARK: - Product
    struct ProductModel: Codable {
        let id: Int
        let title, description: String
        let price: Int
        let discountPercentage, rating: Double?
        let stock: Int?
        let brand, category: String
        let thumbnail: String?
        let images: [String]?
    }


class Product {
    
}
