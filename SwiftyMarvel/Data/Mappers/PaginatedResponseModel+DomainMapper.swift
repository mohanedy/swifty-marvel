//
//  PaginatedResponseModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

// swiftlint:disable force_cast
import Foundation

extension PaginatedResponseModel {
    typealias EntityType = PaginatedResponse
    func toDomain<T>(dataType: T.Type) -> PaginatedResponse<T> {
        return PaginatedResponse<T>(offset: offset,
                                    limit: limit,
                                    total: total,
                                    count: count,
                                    results: results?.map({$0.toDomain() as! T}
                                                         )
        )
    }
}
// swiftlint:enable force_cast
