//
//  DefaultCharactersRepository.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

class DefaultCharactersRepository: CharactersRepository {
    
    private let charactersDataSource: CharactersDataSource
    
    init(charactersDataSource: CharactersDataSource) {
        self.charactersDataSource = charactersDataSource
    }
    
    func getCharacters(from offset: Int, by searchKey: String?) async
    -> Result<PaginatedResponse<Character>, AppError> {
        do {
            let data = try await charactersDataSource.getCharacters(from: offset, by: searchKey)
            let characters = data.toDomain(dataType: Character.self)
            return .success(characters)
        } catch {
            print(error.self)
            return .failure(error.toAppError)
        }
    }
}
