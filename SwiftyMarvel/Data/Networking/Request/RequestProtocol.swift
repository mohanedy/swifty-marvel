//
//  RequestProtocol.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation
import ArkanaKeys
import OSLog

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    var host: String {
       return APIConstants.baseURL
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    func request() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path

        let timeStamp = "\(Date().timeIntervalSince1970)"

        let hash = (timeStamp + ArkanaKeys.Keys.Global().marvelPrivateKey
                    + ArkanaKeys.Keys.Global().marvelPublicKey).md5

        /// Add default query params
        var queryParamsList: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: ArkanaKeys.Keys.Global().marvelPublicKey),
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash)
        ]

        if !urlParams.isEmpty {
            queryParamsList.append(contentsOf: urlParams.map { URLQueryItem(name: $0, value: $1) })
        }

        components.queryItems = queryParamsList

        guard let url = components.url else { throw  NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        Logger.networking.info("🚀 [REQUEST] [\(requestType.rawValue)] \(urlRequest, privacy: .private)")

        return urlRequest
    }
}
