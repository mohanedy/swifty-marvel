//
//  Comic.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

// MARK: - Comic -

struct Comic: Identifiable {
    
    let id: Int?
    let title, description: String?
    let modified: String?
    let thumbnailURL: URL?
    
    // MARK: - Init -
    
    init(id: Int?,
         title: String?,
         description: String? = nil,
         modified: String? = nil,
         thumbnailURL: URL? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.modified = modified
        self.thumbnailURL = thumbnailURL
    }
    
    static func dummyComic() -> Comic {
        return Comic(
            id: 1,
            title: "Dummy Comic",
            description: "Dummy Comic Description",
            modified: "Dummy Comic Modified",
            thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/30/64762a4dbb0e7.jpg")
        )
        
    }
}

// MARK: - Comic + Equatable -

extension Comic: Equatable {
    
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.id == rhs.id
    }
    
}
