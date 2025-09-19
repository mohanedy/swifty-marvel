//
//  CharacterProfileViewModel.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 17/07/2023.
//

import XCTest
import Mockingbird
@testable import SwiftyMarvel

@MainActor
final class CharacterProfileViewModelTests: XCTestCase {
    
    // MARK: - Properties -
    
    var sut: CharacterProfileViewModel!
    var getComicsUCMock: GetComicsUCMock!
    var checkFavoriteUCMock: CheckFavoriteUCMock!
    var toggleFavoriteUCMock: ToggleFavoriteUCMock!
    
    // MARK: - Fake Data -
    
    let fakeComic1 = Comic(id: 1, title: "Comic 1")
    let fakeComic2 = Comic(id: 2, title: "Comic 2")
    
    // MARK: - Setup and Teardown -
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        getComicsUCMock = mock(GetComicsUC.self)
        checkFavoriteUCMock = mock(CheckFavoriteUC.self)
        toggleFavoriteUCMock = mock(ToggleFavoriteUC.self)
        
        sut = CharacterProfileViewModel(
            getComicsUC: getComicsUCMock,
            checkFavoriteUC: checkFavoriteUCMock,
            toggleFavoriteUC: toggleFavoriteUCMock
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        getComicsUCMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests -
    
    func testInitialState() {
        // Then
        XCTAssertEqual(sut.state, .initial)
    }
    
    func testLoadComicsSuccess() async throws {
        // Given
        let expectedComics = [fakeComic1, fakeComic2]
        await given(getComicsUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 2,
                              total: 2,
                              count: 2,
                              results: expectedComics)))
        
        let loadingExpectation = expectation(description: "Loading state changed")
        
        let observation = sut.$state.sink { state in
            if state == .loading {
                loadingExpectation.fulfill()
            }
        }
        
        // When
        await sut.loadComics(forCharacter: 1)
        
        await fulfillment(of: [loadingExpectation], timeout: 1)
        
        // Then
        XCTAssertEqual(sut.comics, expectedComics)
        XCTAssertEqual(sut.state, .success)
        
        observation.cancel()
    }
    
    func testLoadComicsFailure() async throws {
        // Given
        let expectedError = AppError.networkError("Network Error")
        await given(getComicsUCMock.execute(with: any()))
            .willReturn(.failure(expectedError))
        
        let loadingExpectation = expectation(description: "Loading state changed")
        
        let observation = sut.$state.sink { state in
            if state == .loading {
                loadingExpectation.fulfill()
            }
        }
        
        // When
        await sut.loadComics(forCharacter: 1)
        
        await fulfillment(of: [loadingExpectation], timeout: 1)
        
        // Then
        XCTAssertTrue(sut.comics.isEmpty)
        XCTAssertEqual(sut.state, .error(expectedError.localizedDescription))
        observation.cancel()
    }
    
    func testFavoriteToggleChanges() async throws {
        // When
        sut.toggleFavorite(character: Character(id: 1, name: "Character 1"))
        
        // Then
        XCTAssertTrue(sut.isFavorite)
    }
    
    func testIsFavorite() async throws {
        // Given
        let character = Character(id: 1, name: "Character 1")
        let isFavorite = true
        
        given(checkFavoriteUCMock.execute(character: character))
            .willReturn(isFavorite)
        
        // When
        sut.checkFavorite(character: character)
        
        // Then
        XCTAssertEqual(sut.isFavorite, isFavorite)
    }
}
