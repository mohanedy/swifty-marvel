//
//  FavoritesRepository.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

protocol FavoritesRepository {
    
    /// Get all favorites characters from local storage
    func getFavorites() -> Result<[Character], AppError>
    
    /// Check if character is favorite or not
    func isFavorite(character: Character) -> Bool
    
    /// Add character to favorites
    func addFavorite(character: Character)
    
    /// Remove character from favorites
    func removeFavorite(character: Character)
}
