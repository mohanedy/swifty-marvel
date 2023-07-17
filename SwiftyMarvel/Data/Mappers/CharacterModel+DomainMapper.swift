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
                         description: description,
                         modified: modified,
                         thumbnail: thumbnail?.toDomain())
    }
}

// MARK: - ThumbnailModel -

extension ThumbnailModel: DomainMapper {
    func toDomain() -> Thumbnail {
        return Thumbnail(path: path,
                         thumbnailExtension: thumbnailExtension)
    }
}
