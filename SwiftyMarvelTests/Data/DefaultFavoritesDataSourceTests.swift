//
//  DefaultFavoritesDataSourceTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Testing
import CoreData
@testable import SwiftyMarvel

@Suite struct DefaultFavoritesDataSourceTests {
    
    // MARK: - Properties -
    
    var sut: DefaultFavoritesDataSource!
    var coreDataStack: CoreDataStack!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Character 1")
    let fakeCharacter2 = Character(id: 2, name: "Character 2")
    
    // MARK: - Setup and Teardown -
    
    init() async throws {
        coreDataStack = TestCoreDataStack()
        sut = DefaultFavoritesDataSource(dataStack: coreDataStack)
    }
    
    // MARK: - Tests -
    
    @Test("Get favorites success - should return all favorite characters")
    func testGetFavoritesSuccess() throws {
        let derivedContext = coreDataStack.newDerivedContext()
        
        // Given
        let characterEntity1 = CharacterEntity(context: derivedContext)
        characterEntity1.id = 1
        characterEntity1.name = "Character 1"
        
        let characterEntity2 = CharacterEntity(context: derivedContext)
        characterEntity2.id = 2
        characterEntity2.name = "Character 2"
        
        try? derivedContext.save()
        
        // When
        let favorites = try sut.getFavorites()
        
        // Then
        #expect(favorites.count == 2)
        #expect(favorites.contains(where: { $0.id == fakeCharacter1.id }))
        #expect(favorites.contains(where: { $0.id == fakeCharacter2.id }))
    }
    
    @Test("Add favorite success - should add character to favorites")
    func testAddFavoriteSuccess() throws {
        // When
        try sut.addFavorite(character: fakeCharacter1)
        
        // Then
        #expect(try sut.getFavorites().count == 1)
    }
    
    @Test("Remove favorite success - should remove character from favorites")
    func testRemoveFavoriteSuccess() throws {
        // Given
        let derivedContext = coreDataStack.newDerivedContext()
        let characterEntity = CharacterEntity(context: derivedContext)
        characterEntity.id = 1
        characterEntity.name = "Character 1"
        try derivedContext.save()
        
        
        try sut.removeFavorite(character: fakeCharacter1)
        
        // Then
        #expect(try sut.getFavorites().count ==  0)
        
    }
    
    @Test("Is favorite check - should return true if character is favorite, false otherwise")
    func testIsFavorite() throws {
        // Given
        let derivedContext = coreDataStack.newDerivedContext()
        let characterEntity1 = CharacterEntity(context: derivedContext)
        characterEntity1.id = 1
        characterEntity1.name = "Character 1"
        
        let characterEntity2 = CharacterEntity(context: derivedContext)
        characterEntity2.id = 2
        characterEntity2.name = "Character 2"
        
        try derivedContext.save()
        
        // When
        let isFavorite1 = try sut.isFavorite(character: fakeCharacter1)
        let isFavorite2 = try sut.isFavorite(character: fakeCharacter2)
        let isNotFavorite = try sut.isFavorite(character: Character(id: 3, name: "Character 3"))
        
        // Then
        #expect(isFavorite1)
        #expect(isFavorite2)
        #expect(!isNotFavorite)
    }
}
