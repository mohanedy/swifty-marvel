//
//  CheckFavoriteUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

// MARK: - Protocol -

protocol CheckFavoriteUC {
    func execute(character: Character) -> Bool
}

// MARK: - Implementation -

class DefaultCheckFavoriteUC: CheckFavoriteUC {
    private let favoritesRepository: FavoritesRepository
    
    init(favoritesRepository: FavoritesRepository) {
        self.favoritesRepository = favoritesRepository
    }
    
    func execute(character: Character) -> Bool {
        favoritesRepository.isFavorite(character: character)
    }
}
