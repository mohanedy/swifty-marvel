//
//  DefaultCharactersRepositoryTests.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 15/07/2023.
//

import Testing
import Mockingbird
@testable import SwiftyMarvel

@Suite struct DefaultCharactersRepositoryTests {
    
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
    
    init() async throws {
        dataSourceMock = mock(CharactersDataSource.self)
        sut = DefaultCharactersRepository(charactersDataSource: dataSourceMock)
    }
    
    
    // MARK: - Tests -
    
    @Test("Get characters success - should return paginated characters response")
    func testGetCharactersSuccess() async throws {
        // Given
        await given(dataSourceMock.getCharacters(from: any(), by: any()))
            .willReturn(fakeResponse)
        
        // When
        let result = await sut.getCharacters(from: 0, by: nil)
        
        // Then
        #expect(result == .success(fakeResponse.toDomain(dataType: Character.self)))
        #expect(throws: Never.self) { try result.get() }
    }
    
}
