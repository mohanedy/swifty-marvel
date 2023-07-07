//
//  PaginatedResponseModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

struct PaginatedResponseModel<T>: Codable  where T: Codable, T: DomainMapper {
    let offset, limit, total, count: Int?
    let results: [T]?
}
