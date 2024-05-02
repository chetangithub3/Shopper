//
//  APIManager.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation

protocol APIManagerService {
    func fetch(request: URLRequest?) async -> Result<Data, Error>
}

struct APIManager: APIManagerService {
    func fetch(request: URLRequest?) async -> Result<Data, Error> {
        guard let request = request else {
            return .failure(NetworkError.badRequest)
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch {
            return .failure(NetworkError.unknown(nil))
        }
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

public enum NetworkError: Error, LocalizedError {
    case missingRequiredFields(String)
    case invalidParameters(operation: String, parameters: [Any])
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case requestEntityTooLarge
    case unprocessableEntity
    case http(httpResponse: HTTPURLResponse, data: Data)
    case invalidResponse(Data)
    case deleteOperationFailed(String)
    case network(URLError)
    case unknown(Error?)
}

extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
