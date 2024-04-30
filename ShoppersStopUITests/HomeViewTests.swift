//
//  HomeViewTests.swift
//  ShoppersStopUITests
//
//  Created by Chetan Dhowlaghar on 4/30/24.
//
import XCTest
import Foundation

class HomeViewTests: XCTestCase {

    @MainActor func testPickerSelection() {
        let viewModel = ShoppingViewModel()
        let view = HomeView(viewModel: viewModel)
        view.viewModel.selectedCategory = .smartphones
        XCTAssertEqual(view.viewModel.selectedCategory, .smartphones)
    }

    // Add other test cases for HomeView as described in the previous response
}
