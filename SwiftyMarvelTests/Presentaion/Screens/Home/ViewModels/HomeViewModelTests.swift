//
//  HomeViewModelTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation
import XCTest
@testable import SwiftyMarvel

final class HomeViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var sut: HomeViewModel!
    var mockGetCharactersUseCase: MockGetCharactersUseCase!
    
    // MARK: - Fake Data
    let fakeCharacter1 = Character(id: 1, name: "Spider-Man", description: nil, modified: nil, thumbnail: nil, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: [])
    let fakeCharacter2 = Character(id: 2, name: "Iron Man", description: nil, modified: nil, thumbnail: nil, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: [])
    let fakeCharacter3 = Character(id: 3, name: "Hulk", description: nil, modified: nil, thumbnail: nil, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: [])
    let fakeCharacter4 = Character(id: 4, name: "Thor", description: nil, modified: nil, thumbnail: nil, resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: [])
    
    // MARK: - Setup and Teardown
    @MainActor
    override func setUp() {
        super.setUp()
        mockGetCharactersUseCase = MockGetCharactersUseCase()
        sut = HomeViewModel(getCharactersUseCase: mockGetCharactersUseCase, debounceTime: 0)
    }
    
    override func tearDown() {
        sut = nil
        mockGetCharactersUseCase = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    @MainActor
    func testLoadCharactersSuccess() async throws {
        // Given
        let expectedCharacters = [fakeCharacter1, fakeCharacter2]
        let expectedTotalCount = 2
        mockGetCharactersUseCase.result = .success(PaginatedResponse(offset: 0, limit: 2, total: 2, count: 2, results: expectedCharacters))
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertEqual(sut.totalCount, expectedTotalCount)
        XCTAssertEqual(sut.state, .success)
    }
    
    @MainActor
    func testLoadCharactersFailure() async throws {
        // Given
        let expectedError = AppError.networkError("Network Error")
        mockGetCharactersUseCase.result = .failure(expectedError)
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertTrue(sut.characters.isEmpty)
        XCTAssertEqual(sut.state, .error(expectedError.localizedDescription))
    }
    
    @MainActor
    func testSearchCharactersSuccess() async throws {
        // Given
        let expectedSearchText = "Hulk"
        let expectedDebouncedSearchText = "Hulk"
        let expectedCharacters = [fakeCharacter3]
        let expectedTotalCount = 1
        mockGetCharactersUseCase.result = .success(PaginatedResponse(offset: 0, limit: 1, total: 1, count: 1, results: expectedCharacters))
        
        // When
        sut.searchText = expectedSearchText
        await sut.searchCharacters()
        
        // Then
        XCTAssertEqual(sut.searchText, expectedSearchText)
        XCTAssertEqual(sut.debouncedSearchText, expectedDebouncedSearchText)
        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertEqual(sut.totalCount, expectedTotalCount)
        XCTAssertEqual(sut.state, .success)
    }
    
    @MainActor
    func testLoadMoreCharactersIfNeededSuccess() async throws {
        // Given
        let initialCharacters = [fakeCharacter1,
                                 fakeCharacter2]
        
        let moreCharacters = [fakeCharacter3,
                              fakeCharacter4]
        
        let allCharacters = initialCharacters + moreCharacters
        
        let initialTotalCount = 4
        
        mockGetCharactersUseCase.result = .success(PaginatedResponse(offset: 0, limit: 2, total: initialTotalCount, count: 2, results: initialCharacters))
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertEqual(sut.characters.count, initialCharacters.count)
        
        // Given
         mockGetCharactersUseCase.result = .success(PaginatedResponse(offset: 2, limit: 2, total: initialTotalCount, count: 2, results: moreCharacters))
        
         // When
         await sut.loadMoreCharactersIfNeeded(currentItem:sut.characters.last!)
         
         // Then
         XCTAssertEqual(sut.characters.count, allCharacters.count)
         XCTAssertEqual(sut.characters.last?.id , allCharacters.last?.id)
         XCTAssertEqual(sut.state , .success)

    }
}

// MARK:- Mocks

class MockGetCharactersUseCase : GetCharactersUC {
    
    var result : Result<PaginatedResponse<Character> , AppError>!
    
    func execute(with params:GetCharactersParams) async -> Result<PaginatedResponse<Character> , AppError> {
       return result
    }
}
