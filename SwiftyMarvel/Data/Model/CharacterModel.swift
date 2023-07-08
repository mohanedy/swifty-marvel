//
//  CharacterModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//
import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: ThumbnailModel?
    let resourceURI: String?
    let comics, series: ComicsModel?
    let stories: StoriesModel?
    let events: ComicsModel?
    let urls: [URLElementModel]?
}

// MARK: - Comics
struct ComicsModel: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItemModel]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItemModel: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct StoriesModel: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItemModel]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItemModel: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - Thumbnail
struct ThumbnailModel: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElementModel: Codable {
    let type: String?
    let url: String?
}
