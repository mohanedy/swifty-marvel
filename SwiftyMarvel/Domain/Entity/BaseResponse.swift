//
//  BaseResponse.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

struct BaseResponse<T> {
    let code: Int
    let status: String
    let data: T
}

