//
//  FavoritesDataSource.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 01/09/2023.
//

import Foundation
import CoreData

// MARK: - FavoritesDataSource -

protocol FavoritesDataSource {
    func getFavorites() throws -> [Character]
    func isFavorite(character: Character) throws -> Bool
    func addFavorite(character: Character) throws
    func removeFavorite(character: Character) throws
}

// MARK: - DefaultFavoritesDataSource -

class DefaultFavoritesDataSource: FavoritesDataSource {
    private let dataContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        dataContainer.viewContext
    }
    
    init(dataContainer: NSPersistentContainer) {
        self.dataContainer = dataContainer
        
        dataContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unresolved error \(error)")
            }
        }
        
    }
    
    func getFavorites() throws -> [Character] {
        let fetchRequest = CharacterEntity.fetchRequest()
        let result = try managedObjectContext.fetch(fetchRequest)
        return result.map({$0.toDomain()})
    }
    
    func addFavorite(character: Character) throws {
        let characterEntity = character.toCoreDataEntity(in: managedObjectContext)
        try managedObjectContext.save()
    }
    
    func removeFavorite(character: Character) throws {
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", character.id ?? 0)
        let result = try managedObjectContext.fetch(fetchRequest)
        result.forEach({managedObjectContext.delete($0)})
        
        try managedObjectContext.save()
    }
    
    func isFavorite(character: Character) throws -> Bool {
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", character.id ?? 0)
        let result = try managedObjectContext.fetch(fetchRequest)
        
        return !result.isEmpty
    }
}
