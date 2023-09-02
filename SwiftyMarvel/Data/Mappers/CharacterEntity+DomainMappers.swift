//
//  CharacterEntity+DomainMappers.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Foundation
import CoreData

// MARK: - CharacterEntity + DomainMappers -

extension CharacterEntity: DomainMapper {
    typealias EntityType = Character
    
    func toDomain() -> Character {
        return Character(id: Int(id),
                         name: name,
                         description: characterDescription,
                         thumbnailURL: URL(string: thumbnail ?? ""))
    }
}

// MARK: - Character + CoreDataMapper -

extension Character: CoreDataMapper {
    typealias EntityType = CharacterEntity
    
    func toCoreDataEntity(in context: NSManagedObjectContext) -> CharacterEntity {
        let entity = CharacterEntity(context: context)
        entity.id = Int64(id ?? 0)
        entity.name = name
        entity.characterDescription = description
        entity.thumbnail = thumbnailURL?.absoluteString
        return entity
    }
}
