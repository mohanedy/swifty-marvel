//
//  CharacterProfileFeature.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 15/01/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharacterProfileFeature {
    
    struct State: Equatable {
        var comics: [Comic] = []
        var isFavorite: Bool = false
    }
    
    enum Action {
        case loadComics
        case loadComicsResponse(Result<PaginatedResponse<Comic>, AppError>)
        case checkFavorite(Character)
    }
    
    
}
