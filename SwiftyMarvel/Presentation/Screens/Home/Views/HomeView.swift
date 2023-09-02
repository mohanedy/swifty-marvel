//
//  HomeView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = Resolver.shared.resolve(HomeViewModel.self)
    
    var body: some View {
        NavigationStack {
            ZStack {
                BaseStateView(
                    viewModel: viewModel,
                    successView: AnyView(
                        content
                            .padding([.leading, .trailing], 15)
                            .navigationTitle("swiftyMarvel".localized())
                            .searchable(text: $viewModel.searchText,
                                        prompt: "typeCharacterName".localized())
                            .onChange(of: viewModel.debouncedSearchText, perform: { _ in
                                Task {
                                    await viewModel.searchCharacters()
                                }
                            })
                    )//: AnyView
                )//: BaseStateView
            } //: ZStack
            .task {
                await viewModel.loadCharacters()
            }
        } //: NavigationStack
    }
    
    var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.characters) { item in
                    NavigationLink(
                        destination: CharacterProfileView(character: item)
                            .toolbar(.hidden, for: .tabBar)
                    ) {
                        CharacterView(character: item)
                            .task {
                                await viewModel
                                    .loadMoreCharactersIfNeeded(currentItem: item)
                            }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
