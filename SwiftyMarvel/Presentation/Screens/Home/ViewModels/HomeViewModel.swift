//
//  HomeViewModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

@MainActor
final class HomeViewModel: ViewModel, ObservableObject {
    
    // MARK: - Dependencies
    private let getCharactersUseCase: any GetCharactersUC
    
    // MARK: - Properties
    var limit = APIConstants.defaultLimit
    var currentOffset = 0
    var totalCount = 0
    private let debounceTime: Int
    
    
    
    // MARK: - Observable Properties
    @Published var characters: [Character] = []
    @Published var searchText = ""
    @Published var debouncedSearchText = ""
    
    var isSearcing: Bool {
        return !debouncedSearchText.isEmpty
    }
    
    // MARK: - Init
    init(getCharactersUseCase: any GetCharactersUC, debounceTime: Int = 700) {
        self.getCharactersUseCase = getCharactersUseCase
        self.debounceTime = debounceTime
        super.init()
        
        setupSearchDebouncer()
    }
    
    private func setupSearchDebouncer(){
        $searchText
            .debounce(for: .milliseconds(debounceTime), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
    }
    
    // MARK: - Methods
    func loadCharacters(from offset: Int = 0) async {
        state = .loading
        let result = await getCharactersUseCase.execute(with: GetCharactersParams(offset: offset, searchKey: debouncedSearchText.isEmpty ? nil : debouncedSearchText))
        switch result {
        case .success(let data):
            characters.append(contentsOf: data.results ?? [])
            totalCount = data.total ?? 0
            state = .success
        case .failure(let err):
            state = .error(err.localizedDescription)
        }
    }
    
    func searchCharacters() async {
        currentOffset = 0
        characters = []
        await loadCharacters()
    }
    
    
    
    func loadMoreCharactersIfNeeded(currentItem: Character)async {
        guard characters.last?.id == currentItem.id && currentOffset < totalCount
        else { return }
        
        currentOffset += limit
        await loadCharacters(from: currentOffset)
    }
}
