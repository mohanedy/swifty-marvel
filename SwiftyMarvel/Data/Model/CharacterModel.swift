//
//  CharacterModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//
import Foundation

// MARK: - CharacterModel -

struct CharacterModel: Codable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: ThumbnailModel?
    
    init(id: Int? = nil,
         name: String? = nil,
         description: String? = nil,
         modified: String? = nil,
         thumbnail: ThumbnailModel? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
    }
}

// MARK: - ThumbnailModel -

struct ThumbnailModel: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
