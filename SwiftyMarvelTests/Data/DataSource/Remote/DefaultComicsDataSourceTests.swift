//
//  ComicsDataSource.swift
//  SwiftyMarvelTests
//
//  Created by Mohaned Yossry on 20/09/2025.
//

import Foundation
import Testing
import Mockingbird
@testable import SwiftyMarvel

@Suite struct DefaultComicsDataSourceTests {
    
    // MARK: - Properties -
    
    var sut: DefaultComicsDataSource!
    var requestManagerMock: RequestManagerMock!
    
    // MARK: - Fake Data -
    
    let fakeCharacterId = 1009610
    let fakeOffset = 0
    
    let fakeBaseResponse = BaseResponseModel<PaginatedResponseModel<ComicModel>>(
        code: 200,
        status: "Ok",
        data: PaginatedResponseModel(
            offset: 0,
            limit: 20,
            total: 100,
            count: 20,
            results: [
                ComicModel(
                    id: 1,
                    title: "Amazing Spider-Man",
                    description: "The Amazing Spider-Man comic series",
                    modified: "2023-07-14T00:00:00-0400",
                    thumbnail: ThumbnailModel(
                        path: "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73",
                        thumbnailExtension: "jpg"
                    )
                )
            ]
        )
    )
    
    let fakeNetworkError = NetworkError.invalidServerResponse
    
    // MARK: - Setup and Teardown -
    
    init() async throws {
        requestManagerMock = mock(RequestManager.self)
        sut = DefaultComicsDataSource(requestManager: requestManagerMock)
    }
    
    // MARK: - Tests -
    
    @Test("Get comics success - should return paginated comics response")
    func testGetComicsSuccess() async throws {
        // Given
        given(await requestManagerMock.makeRequest(with: any()))
            .willReturn(fakeBaseResponse)
        
        // When
        let result = try await sut.getComics(by: fakeCharacterId, from: fakeOffset)
        
        // Then
        #expect(result.offset == 0)
        #expect(result.limit == 20)
        #expect(result.total == 100)
        #expect(result.count == 20)
        #expect(result.results?.count == 1)
        #expect(result.results?.first?.id == 1)
        #expect(result.results?.first?.title == "Amazing Spider-Man")
    }
    
    @Test("Get comics with zero offset - should handle initial page request")
    func testGetComicsWithZeroOffset() async throws {
        // Given
        given(await requestManagerMock.makeRequest(with: any()))
            .willReturn(fakeBaseResponse)
        
        // When
        let result = try await sut.getComics(by: fakeCharacterId, from: 0)
        
        // Then
        #expect(result.offset == 0)
    }
    
    @Test("Get comics with pagination offset - should handle paginated request")
    func testGetComicsWithPaginationOffset() async throws {
        // Given
        let paginationOffset = 40
        let paginatedResponse = BaseResponseModel<PaginatedResponseModel<ComicModel>>(
            code: 200,
            status: "Ok",
            data: PaginatedResponseModel(
                offset: paginationOffset,
                limit: 20,
                total: 100,
                count: 20,
                results: [ComicModel]()
            )
        )
        given(await requestManagerMock.makeRequest(with: any()))
            .willReturn(paginatedResponse)
        
        // When
        let result = try await sut.getComics(by: fakeCharacterId, from: paginationOffset)
        
        // Then
        #expect(result.offset == paginationOffset)
    }
    
    @Test("Get comics empty response - should handle empty results")
    func testGetComicsEmptyResponse() async throws {
        // Given
        let emptyResponse = BaseResponseModel<PaginatedResponseModel<ComicModel>>(
            code: 200,
            status: "Ok",
            data: PaginatedResponseModel(
                offset: 0,
                limit: 20,
                total: 0,
                count: 0,
                results: [ComicModel]()
            )
        )
        given(await requestManagerMock.makeRequest(with: any()))
            .willReturn(emptyResponse)
        
        // When
        let result = try await sut.getComics(by: fakeCharacterId, from: fakeOffset)
        
        // Then
        #expect(result.total == 0)
        #expect(result.count == 0)
        #expect(result.results?.isEmpty == true)
    }
}
