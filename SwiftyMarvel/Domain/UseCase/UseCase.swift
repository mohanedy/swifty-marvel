//
//  UseCase.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

protocol UseCase{
    associatedtype Params
    associatedtype DataType
    
    func execute(with params: Params)async -> Result<DataType, AppError>
    
}
