//
//  CharacterModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//
import Foundation

// MARK: - CharacterModel -

struct CharacterModel {
    let id: Int?
    let name, characterDescription: String?
    let modified: String?
    let thumbnail: ThumbnailModel?
    
    init(id: Int? = nil,
         name: String? = nil,
         characterDescription: String? = nil,
         modified: String? = nil,
         thumbnail: ThumbnailModel? = nil) {
        self.id = id
        self.name = name
        self.characterDescription = characterDescription
        self.modified = modified
        self.thumbnail = thumbnail
    }
}

// MARK: - CharacterModel + Codable -

extension CharacterModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case characterDescription = "description"
        case modified
        case thumbnail
    }
}
