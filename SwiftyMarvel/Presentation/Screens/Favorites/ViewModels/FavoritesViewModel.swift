//
//  FavoritesViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation

@MainActor
class FavoritesViewModel: ViewModel {
    private let getFavoritesUseCase: GetFavoritesUC
    @Published var favorites: [Character] = []
    
    init(getFavoritesUseCase: GetFavoritesUC) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
    
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
