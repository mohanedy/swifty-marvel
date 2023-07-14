//
//  DefaultCharactersRepositoryTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 15/07/2023.
//

import XCTest
import Mockingbird
@testable import SwiftyMarvel

final class DefaultCharactersRepositoryTests: XCTestCase {
    
    // MARK: - Properties -
    
    var sut: CharactersRepository!
    var dataSourceMock: CharactersDataSourceMock!
    
    // MARK: - Fake Data -
    
    let fakeResponse = PaginatedResponseModel(offset: 0,
                                              limit: 2,
                                              total: 2,
                                              count: 2,
                                              results: [
                                                CharacterModel(
                                                    id: 1,
                                                    name: "Spider-Man")
                                              ])
    let fakeError = NetworkError.invalidServerResponse
    
    // MARK: - Setup and Teardown -
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSourceMock = mock(CharactersDataSource.self)
        sut = DefaultCharactersRepository(charactersDataSource: dataSourceMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        dataSourceMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests -
    
    func testGetCharactersSuccess() async throws {
        // Given
        await given(dataSourceMock.getCharacters(from: any(), by: any()))
            .willReturn(fakeResponse)
        
        // When
        let result = await sut.getCharacters(from: 0, by: nil)
        
        // Then
        XCTAssertNoThrow(try result.get())
    }
}
