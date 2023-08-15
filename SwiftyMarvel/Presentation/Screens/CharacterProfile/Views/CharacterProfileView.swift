//
//  CharacterProfileView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import SwiftUI

struct CharacterProfileView: View {
    
    // MARK: - Properties -
    
    let character: Character
    
    // MARK: - States -
    @StateObject var viewModel = Resolver.shared.resolve(CharacterProfileViewModel.self)
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    coverImageView
                    contentView
                }//: ZStack
            }//: ScrollView
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.hidden, for: .navigationBar)
            .ignoresSafeArea()
            .onAppear {
                Task {
                    await viewModel.loadComics(forCharacter: character.id ?? 0)
                }
            }
        }
    }
    
    // MARK: - View Sections -
    
    private var coverImageView: some View {
        CachedImageView(character.imageURL)
            .aspectRatio(contentMode: .fill)
            .frame(
                height: 350,
                alignment: .center
            )
            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
    }
    
    private var contentView: some View {
        LazyVStack(alignment: .leading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding([.top], 60)
            }
            Spacer()
                .frame(height: 280)
            Text(character.name ?? "")
                .font(.system(.largeTitle, weight: .bold))
                .padding([.bottom], 10)
            
            Text(character.safeDescription)
                .font(.body)
                .padding([.bottom], 10)
            
            comicsSection
            
        }//: VStack
        .padding([.leading, .bottom], 20)
    }
    
    private var comicsSection: some View {
        BaseStateView(viewModel: viewModel,
                      successView: AnyView(VStack(alignment: .leading) {
            Text("comics".localized())
                .font(.system(.title2, weight: .bold))
                .padding([.bottom], 5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.comics) { item in
                        ComicItemView(comic: item)
                    }
                }
            }
        }))
    }
    
}

struct CharacterProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterProfileView(character: Character.dummyCharacter())
    }
}
