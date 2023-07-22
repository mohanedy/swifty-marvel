//
//  Error+AppError.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import Foundation

extension Error {
    /// Converts any error to an `AppError` object.
    var toAppError: AppError {
        if self is NetworkError {
            return .networkError("errorWhileFetchingData")
        }
        return AppError.unknownError("unknownError")
    }
}
