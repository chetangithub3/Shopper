//
//  CartViewModelTests.swift
//  ShoppersStopTests
//
//  Created by Chetan Dhowlaghar on 5/1/24.
//

import XCTest

final class CartViewModelTests: XCTestCase {
    func getTestProduct() -> Product {
        let id = 1
        let category = "electronics"
        let title = "Smartphone"
        let desc = "A powerful smartphone"
        let price = 999
        let product = Product(
            id: id,
            category: category,
            title: title,
            desc: desc,
            price: price,
            thumbnail: nil,
            images: nil
        )
       return product
    }
    func getTestProduct2() -> Product {
        let id = 2
        let category = "electronics"
        let title = "Smartphone"
        let desc = "A powerful smartphone"
        let price = 1
        let product = Product(
            id: id,
            category: category,
            title: title,
            desc: desc,
            price: price,
            thumbnail: nil,
            images: nil
        )
       return product
    }

    func testAddToCart() {
        let viewModel = CartViewModel()
        let product = getTestProduct()
        viewModel.addToCart(product: product)
        XCTAssertNotNil(viewModel.cartItems[product])
    }

    func testUpdateQuantity() {
        let viewModel = CartViewModel()
        let product = getTestProduct()
        viewModel.addToCart(product: product)
        viewModel.updateQuantity(product: product, quantity: 5)
        XCTAssertEqual(viewModel.cartItems[product], 5)
    }

    func testRemoveProduct() {
        let viewModel = CartViewModel()
        let product = getTestProduct()
        viewModel.addToCart(product: product)
        viewModel.removeProduct(product: product)
        XCTAssertNil(viewModel.cartItems[product])
    }

    func testCalculateTotalCost() {
        let viewModel = CartViewModel()
        let product1 = getTestProduct()
        let product2 = getTestProduct2()
        viewModel.addToCart(product: product1)
        viewModel.addToCart(product: product2)
        viewModel.selectedCoupon = nil
        viewModel.calculateTotalCost()
        XCTAssertEqual(viewModel.totalPrice, 1000)
    }

    func testCalculateTotalCostWithCoupon() {
        let viewModel = CartViewModel()
        let product1 = getTestProduct()
        let product2 = getTestProduct2()
        viewModel.addToCart(product: product1)
        viewModel.addToCart(product: product2)
        viewModel.selectedCoupon = Coupon(name: "test", code: "mock", discount: 0.5)
        viewModel.calculateTotalCost()
        XCTAssertEqual(viewModel.totalPrice, 500)
    }

    func testCalculateTotalNumberOfItems() {
        let viewModel = CartViewModel()
        let product1 = getTestProduct()
        let product2 = getTestProduct2()
        viewModel.addToCart(product: product1)
        viewModel.addToCart(product: product2)
        viewModel.calculateTotalNumberOfItems()
        XCTAssertEqual(viewModel.totalNumberOfItems, 2)
    }

    func testRemoveCoupon() {
        let viewModel = CartViewModel()
        let couponToRemove = Coupon(name: "test", code: "mock", discount: 0.5)
        let initialCoupons = [
            Coupon(
                name: "test",
                code: "mock",
                discount: 0.6
            ),
            couponToRemove,
            Coupon(
                name: "test",
                code: "mock",
                discount: 0.7
            )
        ] // Sample coupons
        viewModel.coupons = initialCoupons
        viewModel.removeCoupon(coupon: couponToRemove)
        XCTAssertFalse(viewModel.coupons.contains(couponToRemove))
    }

    func testCheckoutCart() {
        let viewModel = CartViewModel()
        let selectedCoupon = Coupon(name: "test", code: "mock", discount: 0.5)
        viewModel.selectedCoupon = selectedCoupon
        viewModel.checkoutCart()
        XCTAssertTrue(viewModel.cartItems.isEmpty)
        XCTAssertTrue(viewModel.checkout)
    }
}
