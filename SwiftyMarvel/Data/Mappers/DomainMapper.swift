//
//  DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

protocol DomainMapper {
    associatedtype EntityType
    func toDomain() -> EntityType
}
