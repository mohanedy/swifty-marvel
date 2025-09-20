//
//  ComicModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

// MARK: - ComicModel -

struct ComicModel: Codable {
    let id: Int?
    let title, description: String?
    let modified: String?
    let thumbnail: ThumbnailModel?
}
