//
//  HomeViewModelTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Testing
import Mockingbird
import Combine
@testable import SwiftyMarvel

// swiftlint:disable force_unwrapping
@MainActor
final class HomeViewModelTests {
    
    // MARK: - Properties -
    
    var sut: HomeViewModel!
    var getCharactersUCMock: GetCharactersUCMock!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Spider-Man")
    let fakeCharacter2 = Character(id: 2, name: "Iron Man")
    let fakeCharacter3 = Character(id: 3, name: "Hulk")
    let fakeCharacter4 = Character(id: 4, name: "Thor")
    
    // MARK: - Setup and Teardown -
    
    init() async throws {
        getCharactersUCMock = mock(GetCharactersUC.self)
        sut = HomeViewModel(getCharactersUseCase: getCharactersUCMock, debounceTime: 0)
    }
    
    deinit {
        sut = nil
        getCharactersUCMock = nil
    }
    
    // MARK: - Tests -
    
    @Test func testLoadCharactersSuccess() async throws {
        // Given
        let expectedCharacters = [fakeCharacter1, fakeCharacter2]
        await given(getCharactersUCMock.execute(with: any() as GetCharactersParams)).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 2,
                              total: 2,
                              count: 2,
                              results: expectedCharacters)))
        
        // When
        _ = await sut.loadCharacters()
        
        // Then
        #expect(sut.characters == expectedCharacters)
        #expect(sut.state == .success)
    }
    
    @Test func testLoadCharactersFailure() async throws {
        // Given
        let expectedError = AppError.networkError("Network Error")
        await given(getCharactersUCMock.execute(with: any()))
            .willReturn(.failure(expectedError))
        
        // When
        await sut.loadCharacters()
        
        // Then
        #expect(sut.characters.isEmpty)
        #expect(sut.state == .error(expectedError.localizedDescription))
    }
    
    @Test func testSearchCharactersSuccess() async throws {
        // Given
        let expectedSearchText = "Hulk"
        let expectedDebouncedSearchText = "Hulk"
        let expectedCharacters = [fakeCharacter3]
        await given(getCharactersUCMock.execute(with: any())).willReturn(.success(
            PaginatedResponse(offset: 0,
                              limit: 1,
                              total: 1,
                              count: 1,
                              results: expectedCharacters)))
        
        // When
        sut.searchText = expectedSearchText
        await sut.searchCharacters()
        
        // Then
        #expect(sut.searchText == expectedSearchText)
        #expect(sut.debouncedSearchText == expectedDebouncedSearchText)
        #expect(sut.characters == expectedCharacters)
        #expect(sut.state == .success)
    }
    
    @Test func testLoadMoreCharactersIfNeededSuccess() async throws {
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
        #expect(sut.characters.count == initialCharacters.count)
        
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
        #expect(sut.characters.count == allCharacters.count)
        #expect(sut.characters.last?.id == allCharacters.last?.id)
        #expect(sut.state == .success)
    }
}
// swiftlint:enable force_unwrapping
