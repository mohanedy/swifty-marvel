//
//  NetworkManager.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation
import OSLog

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
        let request = try requestData.request()
        var responseStatusCode: Int?
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                responseStatusCode = (response as? HTTPURLResponse)?.statusCode
                throw NetworkError.invalidServerResponse
            }
            logSuccess(request)
            return data
        } catch {
            logError(responseStatusCode, request, error)
            throw error
        }
    }
    
    private func logSuccess(_ request: URLRequest) {
        Logger.networking.info("""
                                    ✅ [\(200)] [\(request.httpMethod  ?? "")] \
                                     \(request, privacy: .private)
                                    """)
    }
    
    private func logError(_ responseStatusCode: Int?, _ request: URLRequest, _ error: Error) {
        Logger.networking.error("""
                                    🛑 [Error] [\(responseStatusCode ?? 0)] [\(request.httpMethod  ?? "")] \
                                     \(request, privacy: .private)
                                     Error Type: \(error.localizedDescription)
                                    """)
    }
}
