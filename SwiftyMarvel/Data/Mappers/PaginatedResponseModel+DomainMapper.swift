//
//  PaginatedResponseModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

extension PaginatedResponseModel {
    typealias EntityType = PaginatedResponse
    func toDomain<T>(dataType: T.Type) -> PaginatedResponse<T> {
        return PaginatedResponse<T>(offset: offset,
                                    limit: limit,
                                    total: total,
                                    count: count,
                                    results: (results ?? []).compactMap({$0.toDomain() as? T}
                                                                )
        )
    }
}
