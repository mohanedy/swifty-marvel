//
//  FavoritesView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 02/09/2023.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(FavoritesViewModel.self)
    
    var body: some View {
        NavigationStack {
            BaseStateView(
                viewModel: viewModel,
                successView: AnyView(
                    content
                        .padding([.leading, .trailing], 15)
                )
            )
            .navigationTitle("Favorites")
        }
        .refreshable {
            viewModel.getFavorites()
        }
        .task {
            viewModel.getFavorites()
        }
        
    }
    
    var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.favorites) { item in
                    NavigationLink(
                        destination: CharacterProfileView(character: item)
                            .toolbar(.hidden, for: .tabBar)
                    ) {
                        CharacterView(character: item)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FavoritesView()
}
