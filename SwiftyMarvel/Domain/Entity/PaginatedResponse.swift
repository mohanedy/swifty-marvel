//
//  PaginatedResponse.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

struct PaginatedResponse<T> {
    let offset, limit, total, count: Int?
    let results: [T]?
}
