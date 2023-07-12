//
//  HomeViewModelTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation
import XCTest
import Mockingbird
@testable import SwiftyMarvel

// swiftlint:disable force_unwrapping
@MainActor
final class HomeViewModelTests: XCTestCase {
    // MARK: - Properties
    var sut: HomeViewModel!
    var getCharactersUCMock: GetCharactersUCMock!
    
    // MARK: - Fake Data
    let fakeCharacter1 = Character(id: 1, name: "Spider-Man")
    let fakeCharacter2 = Character(id: 2, name: "Iron Man")
    let fakeCharacter3 = Character(id: 3, name: "Hulk")
    let fakeCharacter4 = Character(id: 4, name: "Thor")
    
    // MARK: - Setup and Teardown
    override func setUp() {
        super.setUp()
        getCharactersUCMock = mock(GetCharactersUC.self)
        sut = HomeViewModel(getCharactersUseCase: getCharactersUCMock, debounceTime: 0)
    }
    
    override func tearDown() {
        sut = nil
        getCharactersUCMock = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testLoadCharactersSuccess() async throws {
        // Given
        let expectedCharacters = [fakeCharacter1, fakeCharacter2]
        await given(getCharactersUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 2,
                              total: 2,
                              count: 2,
                              results: expectedCharacters)))
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertEqual(sut.state, .success)
    }
    
    func testLoadCharactersFailure() async throws {
        // Given
        let expectedError = AppError.networkError("Network Error")
        await given(getCharactersUCMock.execute(with: any()))
            .willReturn(.failure(expectedError))
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertTrue(sut.characters.isEmpty)
        XCTAssertEqual(sut.state, .error(expectedError.localizedDescription))
    }
    
    func testSearchCharactersSuccess() async throws {
        // Given
        let expectedSearchText = "Hulk"
        let expectedDebouncedSearchText = "Hulk"
        let expectedCharacters = [fakeCharacter3]
        await  given(getCharactersUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 1,
                              total: 1,
                              count: 1,
                              results: expectedCharacters)))
        
        // When
        sut.searchText = expectedSearchText
        await sut.searchCharacters()
        
        // Then
        XCTAssertEqual(sut.searchText, expectedSearchText)
        XCTAssertEqual(sut.debouncedSearchText, expectedDebouncedSearchText)
        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertEqual(sut.state, .success)
    }
    
    func testLoadMoreCharactersIfNeededSuccess() async throws {
        // Given
        let initialCharacters = [fakeCharacter1,
                                 fakeCharacter2]
        let moreCharacters = [fakeCharacter3,
                              fakeCharacter4]
        let allCharacters = initialCharacters + moreCharacters
        let initialTotalCount = 4
        await given(getCharactersUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 2,
                              total: initialTotalCount,
                              count: 2,
                              results: initialCharacters)))
        
        // When
        await sut.loadCharacters()
        
        // Then
        XCTAssertEqual(sut.characters.count, initialCharacters.count)
        
        // Given
        await given(getCharactersUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 2,
                              limit: 2,
                              total: initialTotalCount,
                              count: 2,
                              results: moreCharacters)))
        
        // When
        await sut.loadMoreCharactersIfNeeded(currentItem: sut.characters.last!)
        
        // Then
        XCTAssertEqual(sut.characters.count, allCharacters.count)
        XCTAssertEqual(sut.characters.last?.id, allCharacters.last?.id)
        XCTAssertEqual(sut.state, .success)
    }
}
// swiftlint:enable force_unwrapping
