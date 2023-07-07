//
//  BaseResponseModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: T
}
