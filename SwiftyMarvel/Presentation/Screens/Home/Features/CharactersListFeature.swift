//
//  CharactersListFeature.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 25/12/2023.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharactersListFeature {
    
    // MARK: - Dependencies -
    @Dependency(\.getCharactersUC) private var getCharactersUC: GetCharactersUC
    @Dependency(\.mainQueue) private var mainQueue: AnySchedulerOf<DispatchQueue>
    
    private let limit = APIConstants.defaultLimit
    
    // MARK: - State -
    struct State: Equatable, ViewStatus {
        var status: ViewState = .initial
        var characters: [Character] = []
        var searchText = ""
        var debouncedSearchText = ""
        
        // MARK: - Private properties -
        fileprivate var offset = 0
        fileprivate var totalCount = 0
    }
    
    // MARK: - Action -
    enum Action {
        case loadCharacters
        case loadCharactersIfNeeded(Character)
        case loadCharactersResponse(Result<PaginatedResponse<Character>, AppError>)
        case searchTextDidChange(String)
    }
    
    // MARK: - Reducer -
    var  body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .loadCharacters:
                    return onLoadCharacters(&state)
                    
                case .loadCharactersResponse(let result):
                    return onCharacterResponseLoaded(result, &state)
                    
                case .searchTextDidChange(let searchText):
                    return onSearchCharacters(&state, searchText)
                        .debounce(
                            id: CancelId.searchText,
                            for: 1,
                            scheduler: mainQueue
                        )
                    
                case .loadCharactersIfNeeded(let character):
                    return onLoadCharactersIfNeeded(&state, character)
            }
        }
    }
    
    private func onCharacterResponseLoaded(
        _ result: (Result<PaginatedResponse<Character>, AppError>),
        _ state: inout CharactersListFeature.State
    ) -> Effect<CharactersListFeature.Action> {
        switch result {
            case .success(let data):
                state.characters.append(contentsOf: data.results ?? [])
                state.totalCount = data.total ?? 0
                if state.characters.isEmpty {
                    state.status = .empty
                } else {
                    state.status = .success
                }
            case .failure(let error):
                state.status = .error(error.localizedDescription)
        }
        
        return .none
    }
    
    private func onLoadCharacters(
        _  state: inout CharactersListFeature.State
    ) -> Effect<CharactersListFeature.Action> {
        state.status = .loading
        return .run {[searchText = state.searchText, offset = state.offset] send in
            let result = await getCharactersUC.execute(
                with: GetCharactersParams(
                    offset: offset,
                    searchKey: searchText.isEmpty ? nil : searchText
                )
            )
            await send(.loadCharactersResponse(result))
        }
    }
    
    private func onSearchCharacters(
        _  state: inout CharactersListFeature.State,
        _ searchText: String
    ) -> Effect<CharactersListFeature.Action> {
        if !searchText.isEmpty {
            state.searchText = searchText
            state.offset = 0
            state.characters = []
            
            return .send(.loadCharacters)
        }
        
        return .none
    }
    
    private func onLoadCharactersIfNeeded (
        _  state: inout CharactersListFeature.State,
        _  currentItem: Character
    ) -> Effect<CharactersListFeature.Action> {
        guard state.characters.last?.id == currentItem.id && state.offset < state.totalCount
        else { return .none }
        state.offset += limit
        
        return .send(.loadCharacters)
    }
    
}

extension DefaultGetCharactersUC: DependencyKey {
    static var liveValue: GetCharactersUC {
        Resolver.shared.resolve(GetCharactersUC.self)
    }
    
}

extension DependencyValues {
    var getCharactersUC: GetCharactersUC {
        get { self[DefaultGetCharactersUC.self] }
        set { self[DefaultGetCharactersUC.self] = newValue }
    }
}

fileprivate enum CancelId {
    case searchText
}
