//
//  Character.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Character -

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
    
    // MARK: - Computed Properties -
    
    var imageURL: URL? {
        guard let path = thumbnail?.path, let ext = thumbnail?.thumbnailExtension else { return nil }
        return URL(string: "\(path).\(ext)")
    }
    var safeDescription: String {
        return description != nil && description?.isEmpty != true ?
        description! : "No Description Found"
    }
    
    init(id: Int?, name: String?, description: String? = nil, modified: String? = nil,
         thumbnail: Thumbnail? = nil, resourceURI: String? = nil, comics: Comics? = nil,
         series: Comics? = nil, stories: Stories? = nil, events: Comics? = nil,
         urls: [URLElement]? = []) {
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
        return Character(id: 1016181,
                         name: "Spider Man",
                         // swiftlint:disable line_length
                         description: """
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Iaculis nunc sed augue lacus viverra vitae congue. Arcu cursus euismod quis viverra nibh cras. Sapien eget mi proin sed. Interdum consectetur libero id faucibus nisl. Sed enim ut sem viverra aliquet eget sit amet. Elit sed vulputate mi sit. Libero volutpat sed cras ornare arcu dui. Orci a scelerisque purus semper eget duis at tellus. Ultrices sagittis orci a scelerisque. Tortor posuere ac ut consequat semper viverra nam libero. Tellus in hac habitasse platea. Nisl suscipit adipiscing bibendum est. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. A erat nam at lectus urna duis convallis convallis. Enim neque volutpat ac tincidunt vitae semper quis. Facilisi nullam vehicula ipsum a arcu cursus. Sed augue lacus viverra vitae congue eu consequat ac felis.
                         """,
                         modified: "",
                         thumbnail: Thumbnail(
                            path: "http://i.annihil.us/u/prod/marvel/i/mg/9/03/5239b59f49020",
                            thumbnailExtension: "jpg"
                         ),
                         resourceURI: nil,
                         comics: nil,
                         series: nil,
                         stories: nil,
                         events: nil,
                         urls: [])
    }
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Comics -

struct Comics {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem -

struct ComicsItem {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories -

struct Stories {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem -

struct StoriesItem {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - Thumbnail -

struct Thumbnail {
    let path: String?
    let thumbnailExtension: String?
}

// MARK: - URLElement -

struct URLElement {
    let type: String?
    let url: String?
}
// swiftlint:enable line_length
