//
//  HomeView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 08/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<CharactersListFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            NavigationStack {
                BaseStateViewMod(viewStatus: viewStore.state) {
                    ZStack {
                        content
                            .padding([.leading, .trailing], 15)
                            .navigationTitle("swiftyMarvel".localized())
                            .searchable(
                                text: viewStore.binding(
                                    get: \.searchText,
                                    send: {.searchTextDidChange($0)}
                                ),
                                prompt: "typeCharacterName".localized()
                            )
                    }
                }
                //: ZStack
            }.task {
                viewStore.send(.loadCharacters)
            } //: NavigationStack
        }//: WithViewStore
    }
    
    var content: some View {
        WithViewStore(store, observe: \.characters) { viewStore in
            CustomListView(items: viewStore.state) { item in
                CharacterProfileView(character: item)
            }
        itemView: { item in
            CharacterView(character: item)
                .onAppear {
                    viewStore.send(.loadCharactersIfNeeded(item))
                }
        }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Resolver.shared.resolve(StoreOf<CharactersListFeature>.self)
        )
    }
}
