//
//  PaginatedResponseModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

extension PaginatedResponseModel: DomainMapper {
    typealias EntityType = PaginatedResponse
    
    func toDomain() -> PaginatedResponse<Any> {
        return PaginatedResponse(offset : offset, limit: limit, total: total, count: count, results: results?.map({$0.toDomain()}))
    }
}
