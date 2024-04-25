//
//  CouponService.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/24/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CouponService {
    
    func fetchCoupons() async -> [Coupon] {
        let coupon = Coupon(name: "Welcome to SS - 30% ", code: "ABCDEF", discount: 0.3)
        let coupon2 = Coupon(name: "Loyal customer - 10% ", code: "DEFABC", discount: 0.1)
        
        return [coupon,coupon2]
      
    }
    
  
    
}
