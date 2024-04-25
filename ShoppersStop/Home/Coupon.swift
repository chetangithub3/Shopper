//
//  Coupon.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/24/24.
//

import Foundation
import SwiftData


struct Coupon : Identifiable, Equatable{
    let id = UUID()
    let name: String
    let code: String
    let discount: Double
}


