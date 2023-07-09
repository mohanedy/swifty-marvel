//
//  NetworkManager.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

protocol NetworkManager {
    func makeRequest(with requestData: RequestProtocol) async throws -> Data
}

class DefaultNetworkManager: NetworkManager {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func makeRequest(with requestData: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: requestData.request())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
}
