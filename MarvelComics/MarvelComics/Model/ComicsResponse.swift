//
//  ComicsResponse.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/15/24.
//

import Foundation

struct ComicsResponse: Decodable {
    struct Results: Decodable {
        let results: [Comic]
    }

    struct ResponseData: Decodable {
        let results: [Comic]
    }

    let code: Int
    let data: ResponseData

    enum CodingKeys: CodingKey {
        case code
        case data
    }

    enum DataKeys: CodingKey {
        case results
    }
}
