//
//  Comic.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/15/24.
//

import Foundation

struct Comic: Decodable {
    struct Thumbnail: Decodable {
        let path: URL
        let `extension`: String
    }

    struct TextObject: Decodable {
        let text: String
    }

    let title: String
    let textObjects: [TextObject]
    let thumbnail: Thumbnail

    var thumbnailURL: URL {
        thumbnail.path.appendingPathExtension(thumbnail.`extension`)
    }
}
