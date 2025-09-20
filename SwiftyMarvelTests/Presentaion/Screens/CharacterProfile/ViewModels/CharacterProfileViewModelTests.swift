//
//  CharacterProfileViewModel.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 17/07/2023.
//

import Testing
import Mockingbird
@testable import SwiftyMarvel

@MainActor
@Suite struct CharacterProfileViewModelTests {
    
    // MARK: - Properties -
    
    var sut: CharacterProfileViewModel!
    var getComicsUCMock: GetComicsUCMock!
    var checkFavoriteUCMock: CheckFavoriteUCMock!
    var toggleFavoriteUCMock: ToggleFavoriteUCMock!
    
    // MARK: - Fake Data -
    
    let fakeComic1 = Comic(id: 1, title: "Comic 1")
    let fakeComic2 = Comic(id: 2, title: "Comic 2")
    
    // MARK: - Setup and Teardown -
    
    init() async throws {
        getComicsUCMock = mock(GetComicsUC.self)
        checkFavoriteUCMock = mock(CheckFavoriteUC.self)
        toggleFavoriteUCMock = mock(ToggleFavoriteUC.self)
        
        sut = CharacterProfileViewModel(
            getComicsUC: getComicsUCMock,
            checkFavoriteUC: checkFavoriteUCMock,
            toggleFavoriteUC: toggleFavoriteUCMock
        )
    }
    
    // MARK: - Tests -
    
    @Test("Initial state - should be .initial")
    func testInitialState() {
        // Then
        #expect(sut.state == .initial)
    }
    
    @Test( "Load comics success - should update comics and state to success")
    func testLoadComicsSuccess() async throws {
        // Given
        let expectedComics = [fakeComic1, fakeComic2]
        await given(getComicsUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 2,
                              total: 2,
                              count: 2,
                              results: expectedComics)))
        
        
        // When
        await sut.loadComics(forCharacter: 1)
        
        
        
        // Then
        #expect(sut.comics == expectedComics)
        #expect(sut.state == .success)
    }
    
    @Test( "Load comics failure - should update state to error")
    func testLoadComicsFailure() async throws {
        // Given
        let expectedError = AppError.networkError("Network Error")
        await given(getComicsUCMock.execute(with: any()))
            .willReturn(.failure(expectedError))
        
        // When
        await sut.loadComics(forCharacter: 1)
        
        
        // Then
        #expect(sut.comics.isEmpty)
        #expect(sut.state == .error(expectedError.localizedDescription))
    }
    
    @Test("Toggle favorite - should change isFavorite state")
    func testFavoriteToggleChanges() async throws {
        // When
        sut.toggleFavorite(character: Character(id: 1, name: "Character 1"))
        
        // Then
        #expect(sut.isFavorite)
    }
    
    @Test("Check favorite - should update isFavorite state based on use case result")
    func testIsFavorite() async throws {
        // Given
        let character = Character(id: 1, name: "Character 1")
        let isFavorite = true
        
        given(checkFavoriteUCMock.execute(character: character))
            .willReturn(isFavorite)
        
        // When
        sut.checkFavorite(character: character)
        
        // Then
        #expect(sut.isFavorite == isFavorite)
    }
}
