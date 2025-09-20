//
//  DefaultFavoritesRepositoryTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import Testing
import Mockingbird
@testable import SwiftyMarvel

@Suite struct DefaultFavoritesRepositoryTests {
    
    // MARK: - Properties -
    
    var sut: DefaultFavoritesRepository!
    var dataSourceMock: FavoritesDataSourceMock!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Character 1")
    let fakeCharacter2 = Character(id: 2, name: "Character 2")
    
    // MARK: - Setup and Teardown -
    
    init() async throws {
        dataSourceMock = mock(FavoritesDataSource.self)
        sut = DefaultFavoritesRepository(dataSource: dataSourceMock)
    }
    
    // MARK: - Tests -
    
    @Test("Get favorites success - should return list of favorite characters")
    func testGetFavoritesSuccess() {
        // Given
        given(dataSourceMock.getFavorites()).willReturn([fakeCharacter1, fakeCharacter2])
        
        // When
        let result = sut.getFavorites()
        
        // Then
        switch result {
            case .success(let characters):
                #expect(characters.count == 2)
                #expect(characters.contains(where: { $0.id == fakeCharacter1.id }))
                #expect(characters.contains(where: { $0.id == fakeCharacter2.id }))
            case .failure:
                Issue.record("Expected success, but got failure.")
        }
    }
    
    @Test("Get favorites failure - should return local data fetch error")
    func testGetFavoritesFailure() {
        // Given
        let errorMessage = "The operation couldn't be completed."
        given(dataSourceMock.getFavorites()).willThrow(AppError.localDataFetchError(errorMessage))
        
        // When
        let result = sut.getFavorites()
        
        // Then
        switch result {
            case .success:
                Issue.record("Expected failure, but got success.")
            case .failure(let error):
                if case AppError.localDataFetchError = error {
                    // Success - we got the expected error type
                } else {
                    Issue.record("Expected localDataFetchError, but got different error: \(error)")
                }
        }
    }
    
    @Test("Is favorite check - should correctly identify favorite status")
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
        #expect(isFavorite1)
        #expect(isFavorite2)
        #expect(!isNotFavorite)
    }
    
    @Test("Add favorite - should call data source to add character to favorites")
    func testAddFavorite() {
        // Given
        // No need to specify behavior for adding
        
        // When
        sut.addFavorite(character: fakeCharacter2)
        
        // Then
        verify(dataSourceMock.addFavorite(character: fakeCharacter2)).wasCalled()
    }
    
    @Test("Remove favorite - should call data source to remove character from favorites")
    func testRemoveFavorite() {
        // Given
        // No need to specify behavior for removing
        
        // When
        sut.removeFavorite(character: fakeCharacter1)
        
        // Then
        verify(dataSourceMock.removeFavorite(character: fakeCharacter1)).wasCalled()
    }
}
