//
//  ComicsService.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/15/24.
//

import Foundation

protocol ComicFetchable {
    func fetchComic(id: String) async throws -> Comic
}

class ComicsService {
    static let PublicAPIKey = "YOUR PUBLIC KEY"
    static let PrivateAPIKey = "YOUR PRIVATE KEY"

    private var urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension ComicsService: ComicFetchable {
    func fetchComic(id: String) async throws -> Comic {
        do {
            let data = try await performFetch(id: id)
            let comic = try decodeComics(data: data)
            return comic
        } catch {
            throw error
        }
    }
}

private extension ComicsService {
    func urlComponents(for id: String) -> URLComponents {
        let timestamp = Utils.timestamp()
        let hash = Utils.md5Hash(str: timestamp+Self.PrivateAPIKey+Self.PublicAPIKey)

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/comics/\(id)"
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: Self.PublicAPIKey),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash)
        ]

        return urlComponents
    }

    func performFetch(id: String) async throws -> Data  {
        let urlComponents = urlComponents(for: id)

        let (data, response) = try await urlSession.data(from: URL(string: urlComponents.url?.absoluteString ?? "")!)
        guard let response = response as? HTTPURLResponse else {
            throw ComicsServiceError.serverError
        }

        switch response.statusCode {
            case 400 ..< 500: throw ComicsServiceError.clientError
            case 500 ..< 600: throw ComicsServiceError.serverError
            default: break
        }

        return data
    }

    func decodeComics(data: Data) throws -> Comic {
        let decoded = try JSONDecoder().decode(ComicsResponse.self, from: data)
        guard let comic = decoded.data.results.first else {
            throw ComicsServiceError.parsingError
        }

        return comic
    }
}
