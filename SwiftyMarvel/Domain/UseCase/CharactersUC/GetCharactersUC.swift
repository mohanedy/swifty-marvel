//
//  GetCharactersUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Parameters
struct GetCharacterParams {
    let offset: Int
    let limit: Int
}

// MARK: - Protocol
protocol GetCharacterUC: UseCase {
    func execute(with params: GetCharacterParams) async -> Result<PaginatedResponse<Character>, AppError>
}

// MARK: - Initialization
class DefaultGetCharacterUC {
    
    private var repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
}

// MARK: - Implementation
extension DefaultGetCharacterUC {
    func execute(with params: GetCharacterParams) async -> Result<PaginatedResponse<Character>, AppError> {
        return await repository.getCharacters(offset: params.offset, limit: params.limit)
    }
}


