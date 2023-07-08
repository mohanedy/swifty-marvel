//
//  CharactersDataSource.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

// MARK: - CharactersDataSource
protocol CharactersDataSource {
    func getCharacters(from offset: Int, by searchKey: String?) async throws -> PaginatedResponseModel<CharacterModel>
}

// MARK: - DefaultCharactersDataSource
class DefaultCharactersDataSource: CharactersDataSource {
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getCharacters(from offset: Int, by searchKey: String?) async throws -> PaginatedResponseModel<CharacterModel> {
        let request = CharactersRequest.getCharacters(offset: offset, searchKey: searchKey)
        let response: BaseResponseModel<PaginatedResponseModel<CharacterModel>> = try await requestManager.makeRequest(with: request)
        
        return response.data
    }
}
