//
//  Character.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

// MARK: - Character -

struct Character: Identifiable {
    
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnailURL: URL?
    var isFavorite: Bool?
    
    var safeDescription: String {
        if let description, !description.isEmpty {
            return description
        } else {
            return "No Description Found"
        }
    }
    
    init(id: Int?,
         name: String?,
         description: String? = nil,
         modified: String? = nil,
         thumbnailURL: URL? = nil,
         isFavorite: Bool? = false) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnailURL = thumbnailURL
    }
    static func dummyCharacter() -> Character {
        return Character(id: 1016181,
                         name: "Spider Man",
                         // swiftlint:disable line_length
                         description: """
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Iaculis nunc sed augue lacus viverra vitae congue. Arcu cursus euismod quis viverra nibh cras. Sapien eget mi proin sed. Interdum consectetur libero id faucibus nisl. Sed enim ut sem viverra aliquet eget sit amet. Elit sed vulputate mi sit. Libero volutpat sed cras ornare arcu dui. Orci a scelerisque purus semper eget duis at tellus. Ultrices sagittis orci a scelerisque. Tortor posuere ac ut consequat semper viverra nam libero. Tellus in hac habitasse platea. Nisl suscipit adipiscing bibendum est. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. A erat nam at lectus urna duis convallis convallis. Enim neque volutpat ac tincidunt vitae semper quis. Facilisi nullam vehicula ipsum a arcu cursus. Sed augue lacus viverra vitae congue eu consequat ac felis.
                         """,
                         modified: "",
                         thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/03/5239b59f49020.jpg")
        )
    }
    
}

// MARK: - Character + Equatable -

extension Character: Equatable {
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
    
}

// swiftlint:enable line_length
