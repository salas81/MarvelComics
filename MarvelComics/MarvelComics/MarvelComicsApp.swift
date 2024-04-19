//
//  MarvelComicsApp.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/15/24.
//

import SwiftUI

@main
struct MarvelComicsApp: App {
    var body: some Scene {
        WindowGroup {
            ComicView(viewModel: ComicViewModel(apiClient: ComicsService()))
        }
    }
}
