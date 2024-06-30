//
//  ContainerView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct ContainerView: View {
    var body: some View {
        TabView {
            HomeView(
                store: Resolver.shared.resolve(StoreOf<CharactersListFeature>.self)
            )
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
