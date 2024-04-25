//
//  OnboardingViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    var apiManager = APIManager()
    @Published var error: String?
    var couponService = CouponService()
    
    func fetchProducts() async throws -> ProductsModel?{
        let url = URL(string: "https://dummyjson.com/products")
        let request = URLRequest(url: url!)
        
        let result = await apiManager.fetch(request: request)
        
        switch result {
            case .success(let data):
                do {
                    let products =  try? JSONDecoder.shared.decode(ProductsModel.self, from: data)
                   return products
                }
            case .failure(let error):
                self.error = error.localizedDescription
                return nil
        }
    }
//    
//    func setCoupons() async {
//        let coupon = Coupon(name: "Welcome to SS - 30% ", code: "ABCDEF", discount: 0.3)
//        await couponService.setCoupons(coupons: [coupon])
//    }
//    
    
}


