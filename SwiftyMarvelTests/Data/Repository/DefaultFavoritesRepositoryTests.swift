//
//  DefaultFavoritesRepositoryTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import XCTest
import Mockingbird
@testable import SwiftyMarvel

final class DefaultFavoritesRepositoryTests: XCTestCase {
    
    // MARK: - Properties -
    
    var sut: DefaultFavoritesRepository!
    var dataSourceMock: FavoritesDataSourceMock!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Character 1")
    let fakeCharacter2 = Character(id: 2, name: "Character 2")
    
    // MARK: - Setup and Teardown -
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSourceMock = mock(FavoritesDataSource.self)
        sut = DefaultFavoritesRepository(dataSource: dataSourceMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        dataSourceMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests -
    
    func testGetFavoritesSuccess() {
        // Given
        given(dataSourceMock.getFavorites()).willReturn([fakeCharacter1, fakeCharacter2])
        
        // When
        let result = sut.getFavorites()
        
        // Then
        switch result {
        case .success(let characters):
            XCTAssertEqual(characters.count, 2)
            XCTAssertTrue(characters.contains(where: { $0.id == fakeCharacter1.id }))
            XCTAssertTrue(characters.contains(where: { $0.id == fakeCharacter2.id }))
        case .failure:
            XCTFail("Expected success, but got failure.")
        }
    }
    
    func testGetFavoritesFailure() {
        // Given
        let errorMessage = "The operation couldn’t be completed."
        given(dataSourceMock.getFavorites()).willThrow(AppError.localDataFetchError(errorMessage))
        
        // When
        let result = sut.getFavorites()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, but got success.")
        case .failure:
            XCTAssertTrue(true)
        }
    }
    
    func testIsFavorite() {
        // Given
        let fakeCharacter3 = Character(id: 3, name: "Character 3")
        
        given(dataSourceMock.isFavorite(character: fakeCharacter1)).willReturn(true)
        given(dataSourceMock.isFavorite(character: fakeCharacter2)).willReturn(true)
        given(dataSourceMock.isFavorite(character: fakeCharacter3)).willReturn(false)
        
        // When
        let isFavorite1 = sut.isFavorite(character: fakeCharacter1)
        let isFavorite2 = sut.isFavorite(character: fakeCharacter2)
        let isNotFavorite = sut.isFavorite(character: fakeCharacter3)
        
        // Then
        XCTAssertTrue(isFavorite1)
        XCTAssertTrue(isFavorite2)
        XCTAssertFalse(isNotFavorite)
    }
    
    func testAddFavorite() {
        // Given
        // No need to specify behavior for adding
        
        // When
        sut.addFavorite(character: fakeCharacter2)
        
        // Then
        verify(dataSourceMock.addFavorite(character: fakeCharacter2)).wasCalled()
    }
    
    func testRemoveFavorite() {
        // Given
        // No need to specify behavior for removing
        
        // When
        sut.removeFavorite(character: fakeCharacter1)
        
        // Then
        verify(dataSourceMock.removeFavorite(character: fakeCharacter1)).wasCalled()
    }
}
