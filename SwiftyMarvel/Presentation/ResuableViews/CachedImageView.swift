//
//  CachedImageView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 15/07/2023.
//

import SwiftUI
import NukeUI

struct CachedImageView: View {
    
    let url: URL?
    
    init(_ url: URL?) {
        self.url = url
    }
    
    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image.resizable()
            } else if state.error != nil {
                errorView
            } else {
                loadingView
            }
        }
    }
    
    private var loadingView: some View {
        ZStack(alignment: .center) {
            Color.gray.aspectRatio(contentMode: .fill)
            ProgressView()
        }// :- ZStack
    }
    
    private var errorView: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(URL(string: "https://example.com/image.jpeg"))
    }
}
