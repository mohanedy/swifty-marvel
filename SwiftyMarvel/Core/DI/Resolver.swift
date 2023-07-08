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
    private var container = Container()
    
    func injectModules(){
        
        // MARK: - Utils
        container.register(NetworkManager.self) { _ in
            DefaultNetworkManager()
        }.inObjectScope(.container)
        container.register(RequestManager.self) { resolver in
            DefaultRequestManager(networkManager: resolver.resolve(NetworkManager.self)!)
        }.inObjectScope(.container)
        
        
        // MARK: - Data Sources
        container.register(CharactersDataSource.self) { resolver in
            DefaultCharactersDataSource(requestManager: resolver.resolve(RequestManager.self)!)
        }.inObjectScope(.container)
        
        // MARK: - Repos
        container.register(CharactersRepository.self) { resolver in
            DefaultCharactersRepository(charactersDataSource: resolver.resolve(CharactersDataSource.self)!)
        }.inObjectScope(.container)
        
        // MARK: - Use Cases
        container.register(GetCharactersUC.self) { resolver in
            DefaultGetCharactersUC(repository: resolver.resolve(CharactersRepository.self)!)
        }.inObjectScope(.container)
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
