//
//  AppError.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

enum AppError: Error, Equatable {
    case networkError(String)
    case parsingError(String)
    case serverError(String)
    case unknownError(String)
    case localDataFetchError(String)
}
