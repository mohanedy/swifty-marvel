//
//  Resolver.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation
import Swinject

// swiftlint:disable force_unwrapping

/// Resolver is a singleton class that is responsible for injecting all dependencies in the app.
class Resolver {

    /// The shared instance of the resolver.
    static let shared = Resolver()

    /// The container that holds all the dependencies.
    private var container = Container()

    /// This method is responsible for injecting all dependencies in the app.
    ///
    /// > It should be called only once in the app's lifecycle.
    @MainActor func injectModules() {
        injectUtils()
        injectDataSources()
        injectRepositories()
        injectUseCases()
        injectViewModels()
    }

    /// This method is responsible for resolving a dependency.
    ///
    /// - Parameter type: The type of the dependency to be resolved.
    /// - Returns: The resolved dependency.
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

// MARK: - Injecting Utils
extension Resolver {
    private func injectUtils() {
        container.register(NetworkManager.self) { _ in
            DefaultNetworkManager()
        }.inObjectScope(.container)
        container.register(RequestManager.self) { resolver in
            DefaultRequestManager(networkManager: resolver.resolve(NetworkManager.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting DataSources
extension Resolver {
    private func injectDataSources() {
        container.register(CharactersDataSource.self) { resolver in
            DefaultCharactersDataSource(requestManager: resolver.resolve(RequestManager.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting Repositories
extension Resolver {
    private func injectRepositories() {
        container.register(CharactersRepository.self) { resolver in
            DefaultCharactersRepository(charactersDataSource: resolver.resolve(CharactersDataSource.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting Use Cases
extension Resolver {
    private func injectUseCases() {
        container.register(GetCharactersUC.self) { resolver in
            DefaultGetCharactersUC(repository: resolver.resolve(CharactersRepository.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting ViewModels
extension Resolver {
    @MainActor
    private func injectViewModels() {
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(getCharactersUseCase: resolver.resolve(GetCharactersUC.self)!)
        }
    }
}
// swiftlint:enable force_unwrapping
