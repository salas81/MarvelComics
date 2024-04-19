//
//  APIClientError.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/16/24.
//

import Foundation

enum ComicsServiceError: Error {
    case genericError
    case parsingError
    case clientError
    case serverError
}
