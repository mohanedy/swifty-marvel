//
//  HomeView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = Resolver.shared.resolve(HomeViewModel.self)
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.characters) { item in
                            CharacterView(character: item)
                                .task {
                                    await viewModel.loadMoreCharactersIfNeeded(currentItem: item)
                                }
                        }
                    }
                }
                .padding()
                .navigationTitle("SwiftyMarvel")
                .searchable(text: $viewModel.searchText, prompt: "Type character name...")
                .onChange(of: viewModel.debouncedSearchText, perform: { _ in
                    Task {
                        await viewModel.searchCharacters()
                    }
                })
                .navigationBarTitleDisplayMode(.large)
                if case .loading = viewModel.state {
                    ProgressView()
                }
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
