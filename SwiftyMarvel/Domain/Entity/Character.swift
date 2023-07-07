//
//  Character.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Character
struct Character {
    let id: Int?
    let name, description: String?
    let modified: Date?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?
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
    let type: TypeEnum?
}

enum TypeEnum: String {
    case cover = "cover"
    case interiorStory = "interiorStory"
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

