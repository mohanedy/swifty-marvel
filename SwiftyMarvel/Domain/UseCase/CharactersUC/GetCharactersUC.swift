//
//  GetCharactersUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Parameters -

struct GetCharactersParams {
    
    let offset: Int
    let searchKey: String?
}

// MARK: - Protocol -

protocol GetCharactersUC {

    /// Get a list of characters from the Marvel API.
    func execute(with params: GetCharactersParams) async -> Result<PaginatedResponse<Character>, AppError>
}

// MARK: - Implementation -

struct DefaultGetCharactersUC: GetCharactersUC {
    
    private var repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute(with params: GetCharactersParams) async -> Result<PaginatedResponse<Character>, AppError> {
        return await repository.getCharacters(from: params.offset, by: params.searchKey)
    }
    
}
