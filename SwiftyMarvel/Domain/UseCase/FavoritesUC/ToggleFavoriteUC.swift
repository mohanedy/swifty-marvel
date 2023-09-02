//
//  ToggleFavoriteUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

// MARK: - Protocol -

protocol ToggleFavoriteUC {
    func execute(character: Character)
}

// MARK: - Implementation -

class DefaultToggleFavoriteUC: ToggleFavoriteUC {
    private let favoritesRepository: FavoritesRepository
    
    init(favoritesRepository: FavoritesRepository) {
        self.favoritesRepository = favoritesRepository
    }
    
    func execute(character: Character) {
        if favoritesRepository.isFavorite(character: character) {
            favoritesRepository.removeFavorite(character: character)
        } else {
            favoritesRepository.addFavorite(character: character)
        }
    }
}
