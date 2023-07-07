//
//  Resolver.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation
import Swinject

class Resolver {
    static let shared = Resolver()
    
    //get the IOC container
    private var container: Container {
        let container = Container()
        
        // MARK: - Data Sources
        
        
        // MARK: - Repos
        
        
        // MARK: - Use Cases
        
        
        // MARK: - View Models
        
        
        return container
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
