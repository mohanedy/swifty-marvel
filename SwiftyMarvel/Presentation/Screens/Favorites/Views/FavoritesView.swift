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
            BaseStateView(viewModel: viewModel) {
                content
                    .padding([.leading, .trailing], 15)
            }//: BaseStateView
            .navigationTitle("Favorites")
        }
        .task {
            viewModel.getFavorites()
        }
        
    }
    
    var content: some View {
        CustomListView(items: viewModel.favorites) { item in
            CharacterProfileView(character: item)
        } itemView: { item in
            CharacterView(character: item)
        } 
        .refreshable {
            viewModel.getFavorites()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
