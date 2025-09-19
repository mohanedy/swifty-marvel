//
//  HomeViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

// MARK: - ViewModel -

@MainActor
final class HomeViewModel: ViewModel {
    
    // MARK: - Dependencies -
    
    private let getCharactersUseCase: any GetCharactersUC
    
    // MARK: - Properties -
    
    private var limit = APIConstants.defaultLimit
    private var currentOffset = 0
    private var totalCount = 0
    private let debounceTime: Int
    
    // MARK: - Observable Properties -
    
    @Published var characters: [Character] = []
    @Published var searchText = ""
    @Published var debouncedSearchText = ""
    var isSearching: Bool {
        return !debouncedSearchText.isEmpty
    }
    
    // MARK: - Init -
    
    init(getCharactersUseCase: any GetCharactersUC, debounceTime: Int = 700) {
        self.getCharactersUseCase = getCharactersUseCase
        self.debounceTime = debounceTime
        super.init()
        setupSearchDebouncer()
        
        Task {
            await  loadCharacters()
        }
    }
    
    private func setupSearchDebouncer() {
        $searchText
            .debounce(for: .milliseconds(debounceTime), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
    }
    
}

// MARK: - Actions -

extension HomeViewModel {
    
    func loadCharacters(from offset: Int = 0) async {
        state = .loading
        let result = await getCharactersUseCase.execute(
            with: GetCharactersParams(offset: offset,
                                      searchKey: debouncedSearchText.isEmpty
                                      ? nil : debouncedSearchText))
        switch result {
            case .success(let data):
                if offset == 0 {
                    characters = data.results ?? []
                } else {
                    characters.append(contentsOf: data.results ?? [])
                }
                
                totalCount = data.total ?? 0
                
                
                state = characters.isEmpty ? .empty : .success
                
                
            case .failure(let err):
                state = .error(err.localizedDescription)
        }
    }
    
    func searchCharacters() async {
        currentOffset = 0
        characters = []
        await loadCharacters()
    }
    
    func loadMoreCharactersIfNeeded(currentItem: Character) async {
        guard characters.last?.id == currentItem.id && currentOffset < totalCount
        else { return }
        currentOffset += limit
        await loadCharacters(from: currentOffset)
    }
    
}
