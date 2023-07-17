//
//  RequestManager.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

// MARK: - Request Manager Protocol -

protocol RequestManager {
    var networkManager: NetworkManager { get }
    var parser: DataParser { get }
    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T
}

// MARK: - Default Request Manager
class DefaultRequestManager: RequestManager {
    let networkManager: NetworkManager

    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }

    /// Makes a network request.
    ///
    /// - Parameter requestData: The request data to be sent.
    /// - Returns: The response data decoded to the specified type.
    /// - Throws: An error if the request fails.
    /// - Note: This method is asynchronous.
    /// - Important: The request data should conform to `RequestProtocol`.
    /// - SeeAlso: `RequestProtocol`
    /// - SeeAlso: `NetworkError`
    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T {
        let data = try await networkManager.makeRequest(with: requestData)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

// MARK: - Returns Data Parser -

extension RequestManager {
    var parser: DataParser {
        return DefaultDataParser()
    }
}
