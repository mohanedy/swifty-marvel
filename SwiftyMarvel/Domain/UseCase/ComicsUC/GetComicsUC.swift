//
//  GetComicUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

// MARK: - Parameters -

struct GetComicsParams {
    
    let offset: Int
    let characterID: Int
}

// MARK: - Protocol -

protocol GetComicsUC {
    
    /// Get a list of comics from the Marvel API.
    func execute(with params: GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError>
}

// MARK: - Implementation -

class DefaultGetComicsUC: GetComicsUC {
    
    private var repository: ComicsRepository
    
    init(repository: ComicsRepository) {
        self.repository = repository
    }
    
    func execute(with params: GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError> {
        return await repository.getComics(by: params.characterID, from: params.offset)
    }
    
}
