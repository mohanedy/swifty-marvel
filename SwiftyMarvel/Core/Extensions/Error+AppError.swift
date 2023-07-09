//
//  Error+AppError.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

extension Error {
    var toAppError: AppError {
        if self is NetworkError {
            return .networkError("Network Error")
        }
        return AppError.unknownError("Unknown Error")
    }
}
