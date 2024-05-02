//
//  OnboardingViewModelTests.swift
//  ShoppersStopTests
//
//  Created by Chetan Dhowlaghar on 5/1/24.
//

import XCTest

final class OnboardingViewModelTests: XCTestCase {
    var viewModel = OnboardingViewModel()
    func testFetchProductsFailure() async throws {
        let mockAPIManager = MockAPIManager()
        viewModel.apiManager = mockAPIManager
        do {
            _ = try await viewModel.fetchProducts()
        } catch {
            XCTFail("Expected an error to be thrown")
            XCTAssertEqual(viewModel.error, error.localizedDescription)
            XCTAssertNil(viewModel.fetchedProducts)
        }
    }
}

struct MockAPIManager: APIManagerService {
    func fetch(request: URLRequest?) async -> Result<Data, any Error> {
        return .failure(NetworkError.unknown(nil))
    }
    func mapResponse(response: URLResponse) throws -> Error? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return nil
        }
        switch httpResponse.statusCode {
        case 200..<300:
            return nil
        case 400:
            throw NetworkError.badRequest
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 422:
            throw NetworkError.unprocessableEntity
        default:
            throw NetworkError.unknown(nil)
        }
    }
}
