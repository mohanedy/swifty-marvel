//
//  CharacterModel+Mapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

extension CharacterModel: DomainMapper {
    func toDomain() -> Character {
        return Character(id: id,
                         name: name,
                         description: description,
                         modified: modified,
                         thumbnail: thumbnail?.toDomain())
    }
}


extension ThumbnailModel: DomainMapper {
    func toDomain() -> Thumbnail {
        return Thumbnail(path: path,
                         thumbnailExtension: thumbnailExtension)
    }
}
