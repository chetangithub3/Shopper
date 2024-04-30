//
//  Products.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation
import SwiftData
import UIKit
    // MARK: - Products
    struct ProductsModel: Decodable, Encodable {
        let products: [ProductModel]
        let total, skip, limit: Int?
    }

    // MARK: - Product
    struct ProductModel: Codable {
        let id: Int?
        let title, description: String?
        let price: Int?
        let discountPercentage, rating: Double?
        let stock: Int?
        let brand, category: String?
        let thumbnail: String?
        let images: [String]?
    }

@Model
class Product: Hashable {
    let id: Int
    let category: String
    let title: String
    let desc: String
    let price: Int
    let thumbnail: String?
    let images: [String]?

    init(id: Int, category: String, title: String, desc: String, price: Int, thumbnail: String?, images: [String]?) {
        self.id = id
        self.category = category
        self.title = title
        self.desc = desc
        self.price = price
        self.thumbnail = thumbnail
        self.images = images
    }
}
