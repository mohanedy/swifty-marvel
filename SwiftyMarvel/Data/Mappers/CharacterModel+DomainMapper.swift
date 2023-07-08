//
//  CharacterModel+Mapper.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 07/07/2023.
//

import Foundation

extension CharacterModel: DomainMapper {
    
    func toDomain() -> Character {
        return Character(id: id, name: name, description: description, modified: modified, thumbnail: thumbnail?.toDomain(), resourceURI: resourceURI, comics: comics?.toDomain(), series: series?.toDomain(), stories: stories?.toDomain(), events: events?.toDomain(), urls: urls?.map({$0.toDomain()}))
    }
}

extension ComicsModel: DomainMapper {
    func toDomain() -> Comics {
        return Comics(available: available, collectionURI: collectionURI, items: items?.map({$0.toDomain()}), returned: returned)
    }
}

extension ComicsItemModel: DomainMapper {
    
    func toDomain() -> ComicsItem {
        return ComicsItem(resourceURI: resourceURI, name: name)
    }
}

extension StoriesModel: DomainMapper {
    
    func toDomain() -> Stories {
        return Stories(available: available, collectionURI: collectionURI, items: items?.map({$0.toDomain()}), returned: returned)
    }
}

extension StoriesItemModel: DomainMapper {
    
    func toDomain() -> StoriesItem {
        return StoriesItem(resourceURI: resourceURI, name: name, type: type)
    }
}

extension ThumbnailModel: DomainMapper {
    
    func toDomain() -> Thumbnail {
        return Thumbnail(path: path, thumbnailExtension: thumbnailExtension)
    }
}

extension URLElementModel: DomainMapper {
    
    func toDomain() -> URLElement {
        return URLElement(type: type, url: url)
    }
}






