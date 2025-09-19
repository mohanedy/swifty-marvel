//
//  PaginatedResponseModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

extension PaginatedResponseModel {
    typealias EntityType = PaginatedResponse
    func toDomain<DomainType>(dataType: DomainType.Type) -> PaginatedResponse<DomainType> {
        return PaginatedResponse<DomainType>(offset: offset,
                                             limit: limit,
                                             total: total,
                                             count: count,
                                             results: (results ?? []).compactMap({$0.toDomain() as? DomainType}
                                                                                )
        )
    }
}
