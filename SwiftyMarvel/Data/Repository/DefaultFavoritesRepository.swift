//
//  DefaultFavoritesRepository.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation
import OSLog

class DefaultFavoritesRepository: FavoritesRepository {
    private let dataSource: FavoritesDataSource
    
    init(dataSource: FavoritesDataSource) {
        self.dataSource = dataSource
    }
    
    func getFavorites() -> Result<[Character], AppError> {
        do {
            let characters = try dataSource.getFavorites()
            return .success(characters)
        } catch {
            return .failure(.localDataFetchError(error.localizedDescription))
        }
    }
    
    func isFavorite(character: Character) -> Bool {
        do {
            let result = try dataSource.isFavorite(character: character)
            return result
        } catch {
            return false
        }
    }
    
    func addFavorite(character: Character) {
        do {
            try dataSource.addFavorite(character: character)
        } catch {
            Logger.localDataSource.error("Local DS: \(error.localizedDescription)")
        }
    }
    
    func removeFavorite(character: Character) {
        do {
            try dataSource.removeFavorite(character: character)
        } catch {
            Logger.localDataSource.error("Local DS: \(error.localizedDescription)")
        }
    }
}
