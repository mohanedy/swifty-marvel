//
//  Comic.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

struct Comic: Identifiable, Equatable {
    let id: Int?
    let title, description: String?
    let modified: String?
    let isbn, upc, diamondCode, ean: String?
    let issn, format: String?
    let thumbnail: Thumbnail?
    
    // MARK: - Computed Properties -
    var imageURL: URL? {
        guard let path = thumbnail?.path, let ext = thumbnail?.thumbnailExtension else { return nil }
        return URL(string: "\(path).\(ext)")
    }
    
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.id == rhs.id
    }
    
    static func dummyComic() -> Comic {
        return Comic(
            id: 1,
            title: "Dummy Comic",
            description: "Dummy Comic Description",
            modified: "Dummy Comic Modified",
            isbn: "Dummy Comic ISBN",
            upc: "Dummy Comic UPC",
            diamondCode: "Dummy Comic Diamond Code",
            ean: "Dummy Comic EAN",
            issn: "Dummy Comic ISSN",
            format: "Dummy Comic Format",
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/9/30/64762a4dbb0e7",
                thumbnailExtension: "jpg"))
        
    }
}
