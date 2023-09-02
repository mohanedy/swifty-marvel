//
//  ThumbnailModel.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 01/09/2023.
//

import Foundation

// MARK: - ThumbnailModel -

struct ThumbnailModel {
    let path: String?
    let thumbnailExtension: String?
    
    var url: URL? {
        guard let path, let ext = thumbnailExtension else { return nil }
        return URL(string: "\(path).\(ext)")
    }
    
    init(
        path: String? = nil,
        thumbnailExtension: String? = nil
    ) {
        self.path = path
        self.thumbnailExtension = thumbnailExtension
    }
    
}

// MARK: - ThumbnailModel + Codable -

extension ThumbnailModel: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
