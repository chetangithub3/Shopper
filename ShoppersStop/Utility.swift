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
        let bounds = UIScreen.main.bounds
        let width = min(bounds.width, bounds.height)
        let height = max(bounds.width, bounds.height)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}

extension Color {
    static let purple = Color(UIColor(red: 1.0, green: 0.615, blue: 0.110, alpha: 1.0))
}

extension NumberFormatter {
    static var twoDecimalPlaces: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
