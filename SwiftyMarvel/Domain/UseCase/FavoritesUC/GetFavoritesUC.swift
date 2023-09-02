//
//  GetFavoritesUC.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 01/09/2023.
//

import Foundation

// MARK: - Protocol -

protocol GetFavoritesUC {
    func execute() -> Result<[Character], AppError>
}

// MARK: - Implementation -

class DefaultGetFavoritesUC: GetFavoritesUC {
    private let favoritesRepository: FavoritesRepository
    
    init(favoritesRepository: FavoritesRepository) {
        self.favoritesRepository = favoritesRepository
    }
    
    func execute() -> Result<[Character], AppError> {
        favoritesRepository.getFavorites()
    }
}
