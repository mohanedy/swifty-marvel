//
//  DefaultFavoritesDataSourceTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import XCTest
import CoreData
@testable import SwiftyMarvel

class DefaultFavoritesDataSourceTests: XCTestCase {
    
    // MARK: - Properties -
    
    var sut: DefaultFavoritesDataSource!
    var coreDataStack: CoreDataStack!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Character 1")
    let fakeCharacter2 = Character(id: 2, name: "Character 2")
    
    // MARK: - Setup and Teardown -
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataStack = TestCoreDataStack()
        sut = DefaultFavoritesDataSource(dataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests -
    
    func testGetFavoritesSuccess() {
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
        do {
            let favorites = try sut.getFavorites()
            
            // Then
            XCTAssertEqual(favorites.count, 2)
            XCTAssertTrue(favorites.contains(where: { $0.id == fakeCharacter1.id }))
            XCTAssertTrue(favorites.contains(where: { $0.id == fakeCharacter2.id }))
        } catch {
            XCTFail("Expected success, but got failure: \(error)")
        }
    }
    
    func testAddFavoriteSuccess() {
        // Given
        let characterEntity = CharacterEntity()
        
        // When
        do {
            try sut.addFavorite(character: fakeCharacter1)
            
            // Then
            XCTAssertEqual(try? sut.getFavorites().count, 1)
        } catch {
            XCTFail("Expected success, but got failure: \(error)")
        }
    }
    
    func testRemoveFavoriteSuccess() {
        // Given
        let derivedContext = coreDataStack.newDerivedContext()
        let characterEntity = CharacterEntity(context: derivedContext)
        characterEntity.id = 1
        characterEntity.name = "Character 1"
        try? derivedContext.save()
        
        do {
            // When
            try sut.removeFavorite(character: fakeCharacter1)
            
            // Then
            XCTAssertEqual(try? sut.getFavorites().count, 0)

        } catch {
            XCTFail("Expected success, but got failure: \(error)")
        }
    }
    
    func testIsFavorite() {
        // Given
        let derivedContext = coreDataStack.newDerivedContext()
        let characterEntity1 = CharacterEntity(context: derivedContext)
        characterEntity1.id = 1
        characterEntity1.name = "Character 1"
        
        let characterEntity2 = CharacterEntity(context: derivedContext)
        characterEntity2.id = 2
        characterEntity2.name = "Character 2"
        
        try? derivedContext.save()
        
        // When
        do {
            let isFavorite1 = try sut.isFavorite(character: fakeCharacter1)
            let isFavorite2 = try sut.isFavorite(character: fakeCharacter2)
            let isNotFavorite = try sut.isFavorite(character: Character(id: 3, name: "Character 3"))
            
            // Then
            XCTAssertTrue(isFavorite1)
            XCTAssertTrue(isFavorite2)
            XCTAssertFalse(isNotFavorite)
        } catch {
            XCTFail("Expected success, but got failure: \(error)")
        }
    }
}
