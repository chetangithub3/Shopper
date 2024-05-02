//
//  CartViewModel.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/23/24.
//

import Foundation

class CartViewModel: ObservableObject {
    var couponService = CouponService()

    @Published var cartItems: [Product: Int] = [:] {
        didSet {
            calculateDiscount()
            calculateTotalCost()
            calculateTotalNumberOfItems()
            calculateCartTotal()
        }
    }
    @Published var selectedCoupon: Coupon? {
        didSet {
            calculateDiscount()
            calculateTotalCost()
            calculateCartTotal()
        }
    }
    @Published var discountedAmount: Double = 0.0
    @Published var cartTotal: Double = 0.0
    @Published var totalPrice: Double = 0.0
    @Published var totalNumberOfItems: Int = 0
    @Published var coupons: [Coupon] = []
    @Published var checkout = false

    func addToCart(product: Product) {
        cartItems[product] = 1
    }

    func updateQuantity(product: Product, quantity: Int) {
        cartItems[product] = quantity
    }

    func removeProduct(product: Product) {
        cartItems.removeValue(forKey: product)
    }

    func calculateTotalCost() {
        var totalCost = 0
        for cartItem in cartItems {
            let quantity = cartItem.value
            let costPerEach = cartItem.key.price
            totalCost += costPerEach * quantity
        }
        self.totalPrice = Double(totalCost)
        if let discount = selectedCoupon?.discount {
            self.totalPrice = (1 - discount) * totalPrice
        }
    }

    func calculateCartTotal() {
        var cartTotal = 0
        for cartItem in cartItems {
            let quantity = cartItem.value
            let costPerEach = cartItem.key.price
            cartTotal += costPerEach * quantity
        }
        self.cartTotal = Double(cartTotal)
    }

    func calculateDiscount() {
        if let discount = selectedCoupon?.discount {
            self.discountedAmount = discount * totalPrice
        }
    }

    func calculateTotalNumberOfItems() {
        self.totalNumberOfItems = cartItems.values.reduce(0, +)
    }

    func fetchCoupons() async {
        let coupons = await couponService.fetchCoupons()
        await MainActor.run {
            self.coupons = coupons
        }
    }

    func removeCoupon(coupon: Coupon) {
        if let index = coupons.firstIndex(where: { $0.id == coupon.id }) {
            coupons.remove(at: index)
        }
    }

    func checkoutCart() {
        if let selectedCoupon = selectedCoupon {
            removeCoupon(coupon: selectedCoupon)
        }
        cartItems.removeAll()
        checkout = true
    }
}
