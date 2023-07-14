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
    
    private let getComicsUC: any GetComicsUC
    
    // MARK: - Properties -
    
    private var currentOffset = 0
    
    // MARK: - Observable Properties -
    
    @Published var comics: [Comic] = []
    
    // MARK: - Init -
    
    init(getComicsUC: any GetComicsUC) {
        self.getComicsUC = getComicsUC
    }
}

// MARK: - Actions -

extension CharacterProfileViewModel {
    
    func loadComics(byCharacter id: Int) async {
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
}
