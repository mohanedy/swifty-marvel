//
//  CharactersRepository.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

protocol CharactersRepository {
    func getCharacters(offset: Int, limit: Int) async -> Result<PaginatedResponse<Character>, AppError>
}
