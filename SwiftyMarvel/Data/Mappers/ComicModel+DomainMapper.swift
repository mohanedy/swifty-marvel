//
//  ComicModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 14/07/2023.
//

import Foundation

extension ComicModel: DomainMapper {
    
    func toDomain() -> Comic {
        return Comic(
            id: id,
            title: title,
            description: description,
            modified: modified,
            isbn: isbn,
            upc: upc,
            diamondCode: diamondCode,
            ean: ean,
            issn: issn,
            format: format,
            thumbnail: thumbnail?.toDomain()
        )
    }
}
