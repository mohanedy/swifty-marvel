//
//  ComicItemView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 15/07/2023.
//

import SwiftUI
import Kingfisher

struct ComicItemView: View {
    
    let comic: Comic
    
    var body: some View {
        VStack(alignment: .center) {
            CachedImageView(comic.imageURL)
                .aspectRatio(2/3, contentMode: .fit)
                .cornerRadius(15)
                .frame(height: 200)
            
            Text(comic.title ?? "")
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(width: 150)
        }//: VStack
        .padding([.leading], 10)
    }
}

struct ComicItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ComicItemView(comic: Comic.dummyComic())
    }
}
