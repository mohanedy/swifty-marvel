//
//  Character.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Character
struct Character: Identifiable, Equatable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?
    
    var imageURL: URL? {
        guard let path = thumbnail?.path, let ext = thumbnail?.thumbnailExtension else { return nil }
        return URL(string: "\(path).\(ext)")
    }
    
    init(id: Int?, name: String?, description: String?, modified: String?, thumbnail: Thumbnail?, resourceURI: String?, comics: Comics?, series: Comics?, stories: Stories?, events: Comics?, urls: [URLElement]?) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
    
    static func dummyCharacter() -> Character {
        return Character(id: 1, name: "Spider Man", description: "Superhero", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/03/5239b59f49020", thumbnailExtension: "jpg"), resourceURI: nil, comics: nil, series: nil, stories: nil, events: nil, urls: [])
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Comics
struct Comics {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem  {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - Thumbnail
struct Thumbnail {
    let path: String?
    let thumbnailExtension: String?
}

// MARK: - URLElement
struct URLElement {
    let type: String?
    let url: String?
}

