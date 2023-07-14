//
//  CharactersDataSource.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

typealias CharactersResponse = BaseResponseModel<PaginatedResponseModel<CharacterModel>>

// MARK: - Protocol -

protocol CharactersDataSource {
    func getCharacters(from offset: Int, by searchKey: String?) async throws -> PaginatedResponseModel<CharacterModel>
}

// MARK: - Implementation -

class DefaultCharactersDataSource: CharactersDataSource {
    private let requestManager: RequestManager
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    func getCharacters(from offset: Int, by searchKey: String?) async throws -> PaginatedResponseModel<CharacterModel> {
        let request = CharactersRequest.getCharacters(offset: offset, searchKey: searchKey)
        let response: CharactersResponse = try await requestManager.makeRequest(with: request)
        return response.data
    }
}
