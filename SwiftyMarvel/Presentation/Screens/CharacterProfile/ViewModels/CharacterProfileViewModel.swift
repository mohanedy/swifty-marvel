//
//  CharacterProfileViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

// MARK: - ViewModel -

@MainActor
final class CharacterProfileViewModel: ViewModel {
    
    // MARK: - Dependencies -
    
    private let getComicsUC: GetComicsUC
    private let checkFavoriteUC: CheckFavoriteUC
    private let toggleFavoriteUC: ToggleFavoriteUC
    
    // MARK: - Properties -
    
    private var currentOffset = 0
    
    // MARK: - Observable Properties -
    
    @Published var comics: [Comic] = []
    @Published var isFavorite: Bool = false
    
    // MARK: - Init -
    
    init(getComicsUC: GetComicsUC,
         checkFavoriteUC: CheckFavoriteUC,
         toggleFavoriteUC: ToggleFavoriteUC) {
        self.getComicsUC = getComicsUC
        self.checkFavoriteUC = checkFavoriteUC
        self.toggleFavoriteUC = toggleFavoriteUC
    }
}

// MARK: - Actions -

extension CharacterProfileViewModel {
    
    func loadComics(forCharacter id: Int) async {
        state = .loading
        let result = await getComicsUC.execute(with: GetComicsParams(offset: 0, characterID: id))
        switch result {
        case .success(let data):
            comics.append(contentsOf: data.results ?? [])
            state = .success
        case .failure(let err):
            state = .error(err.localizedDescription)
        }
    }
    
    func checkFavorite(character: Character) {
        let result = checkFavoriteUC.execute(character: character)
        isFavorite = result
    }
    
    func toggleFavorite(character: Character) {
        toggleFavoriteUC.execute(character: character)
        isFavorite.toggle()
    }
}
