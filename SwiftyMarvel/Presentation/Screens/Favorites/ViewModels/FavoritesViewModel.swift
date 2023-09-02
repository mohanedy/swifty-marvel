//
//  FavoritesViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

@MainActor
class FavoritesViewModel: ViewModel {
    
    // MARK: - Dependencies -
    
    private let getFavoritesUseCase: GetFavoritesUC
    
    // MARK: - Observable Properties -
    
    @Published var favorites: [Character] = []
    
    // MARK: - Init -
    
    init(getFavoritesUseCase: GetFavoritesUC) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
}

// MARK: - Actions -

extension FavoritesViewModel {
    
    func getFavorites() {
        state = .loading
        let result = getFavoritesUseCase.execute()
        
        switch result {
        case .success(let data):
            if !data.isEmpty {
                state = .success
                favorites = data
            } else { state = .empty }
            
        case .failure(let error):
            state = .error(error.localizedDescription)
        }
    }
}
