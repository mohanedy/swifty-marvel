//
//  FavoritesRepository.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

protocol FavoritesRepository {
    func getFavorites() -> Result<[Character], AppError>
    func isFavorite(character: Character) -> Bool
    func addFavorite(character: Character)
    func removeFavorite(character: Character)
}
