//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/16/24.
//

import Foundation

class ComicViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var hasError = false
    @Published var comic: Comic?

    let apiClient: ComicFetchable

    init(apiClient: ComicFetchable) {
        self.apiClient = apiClient
    }

    @MainActor
    func fetchComic() async {
        hasError = false
        isLoading = true

        // Hardcoded comic id per specs
        guard let comic = try? await apiClient.fetchComic(id: "1994") else {
            comic = nil
            isLoading = false
            hasError = true
            return
        }

        isLoading = false
        hasError = false
        self.comic = comic
    }

    var comicTitle: String {
        comic?.title ?? ""
    }

    var comicDescription: String {
        comic?.textObjects.first?.text ?? ""
    }

    var errorMessage: String {
        "There was an error fetching the comic"
    }

    var thumbnailURL: URL? {
        comic?.thumbnailURL
    }
}
