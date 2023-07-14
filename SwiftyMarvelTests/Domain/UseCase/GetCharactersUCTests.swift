//
//  GetCharactersUCTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 15/07/2023.
//

import Foundation
import XCTest
import Mockingbird
@testable import SwiftyMarvel

final class GetCharactersUCTests: XCTestCase {
    
    // MARK: - Properties -
    
    var sut: GetCharactersUC!
    var repositoryMock: CharactersRepositoryMock!
    var params: GetCharactersParams!
    
    // MARK: - Fake Data -
    
    let fakeCharacter1 = Character(id: 1, name: "Spider-Man")
    let fakeCharacter2 = Character(id: 2, name: "Iron Man")
    let fakeError = AppError.networkError("Network Error")
    
    // MARK: - Setup and Teardown -
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoryMock = mock(CharactersRepository.self)
        sut = DefaultGetCharactersUC(repository: repositoryMock)
        params = GetCharactersParams(offset: 0, searchKey: nil)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        repositoryMock = nil
        params = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests -
    
    func testExecuteSuccess() async throws {
        // Given
        let expectedResponse = PaginatedResponse(offset: 0,
                                                 limit: 2,
                                                 total: 2,
                                                 count: 2,
                                                 results: [fakeCharacter1, fakeCharacter2])
        
        await given(repositoryMock.getCharacters(from: any(), by: any()))
            .willReturn(.success(expectedResponse))
        
        // When
        let result = await sut.execute(with: params)
        
        // Then
        XCTAssertEqual(result, .success(expectedResponse))
    }
    
    func testExecuteFailure() async throws {
        // Given
        await given(repositoryMock.getCharacters(from: any(), by: any()))
            .willReturn(.failure(fakeError))
        
        // When
        let result = await sut.execute(with: params)
        
        // Then
        XCTAssertEqual(result, .failure(fakeError))
    }
    
    func testExecutePagination() async throws {
        // Given
        let expectedResponse1 = PaginatedResponse(offset: 0,
                                                  limit: 2,
                                                  total: 4,
                                                  count: 2,
                                                  results: [fakeCharacter1, fakeCharacter2])
        
        let expectedResponse2 = PaginatedResponse(offset: 2,
                                                  limit: 2,
                                                  total: 4,
                                                  count: 2,
                                                  results: [fakeCharacter1, fakeCharacter2])
        
        await given(repositoryMock.getCharacters(from: 0, by: any()))
            .willReturn(.success(expectedResponse1))
        await given(repositoryMock.getCharacters(from: 2, by: any()))
            .willReturn(.success(expectedResponse2))
        
        // When
        let result1 = await sut.execute(with: GetCharactersParams(offset: 0, searchKey: nil))
        let result2 = await sut.execute(with: GetCharactersParams(offset: 2, searchKey: nil))

        // Then
        XCTAssertEqual(result1, .success(expectedResponse1))
        XCTAssertEqual(result2, .success(expectedResponse2))
    }

}
