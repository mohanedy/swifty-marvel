//
//  NetworkManager.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

/// The network manager protocol.
/// It is responsible for making network requests.
protocol NetworkManager {
    func makeRequest(with requestData: RequestProtocol) async throws -> Data
}

class DefaultNetworkManager: NetworkManager {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    /// Makes a network request.
    /// 
    /// - Parameter requestData: The request data
    /// - Returns: The response data
    /// - Throws: An error if the request fails.
    /// - Note: This method is asynchronous.
    /// - Important: The request data should conform to `RequestProtocol`.
    /// - SeeAlso: `RequestProtocol`
    func makeRequest(with requestData: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: requestData.request())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
}
