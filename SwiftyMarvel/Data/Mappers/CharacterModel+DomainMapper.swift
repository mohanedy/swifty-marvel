//
//  CharacterModel+Mapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - CharacterModel -

extension CharacterModel: DomainMapper {
    func toDomain() -> Character {
        return Character(id: id,
                         name: name,
                         description: characterDescription,
                         modified: modified,
                         thumbnailURL: thumbnail?.url)
    }
}
