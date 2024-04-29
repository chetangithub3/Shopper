//
//  Utility.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import Foundation
import SwiftUI

enum ProductCategory: String, CaseIterable {
    case all
    case groceries
    case fragrances
    case laptops
    case skincare
    case smartphones
}

extension View {
    func getScreenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
