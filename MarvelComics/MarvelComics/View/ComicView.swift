//
//  ComicView.swift
//  MarvelComics
//
//  Created by Lorenzo Decaria on 4/15/24.
//

import SwiftUI

struct ComicView: View {
    @ObservedObject var viewModel: ComicViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.comic == nil {
                EmptyView()
            } else {
                viewModel.hasError ? AnyView(errorView) : AnyView(comicView)
            }
        }
        .task {
            await viewModel.fetchComic()
        }
    }
}

private extension ComicView {
    var loadingView: some View {
        ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .blue))
              .scaleEffect(2.0, anchor: .center)
    }

    var errorView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .padding(.bottom, 20)
            Text(viewModel.errorMessage)
        }
    }

    var comicView: some View {
        VStack {
            thumbnail
            titleLabel
            descriptionLabel
            attributionText
        }
    }

    var thumbnail: some View {
        AsyncImage(url: viewModel.thumbnailURL) { image in
            image.resizable(resizingMode: .tile)
        } placeholder: {
            ProgressView()
        } // Could add padding here too but I like how the image looks without!
        .accessibilityIdentifier("thumbnail")
    }

    var titleLabel: some View {
        Text(viewModel.comicTitle)
            .font(.title)
            .bold()
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .accessibilityIdentifier("titleLabel")
    }

    var descriptionLabel: some View {
        Text(viewModel.comicDescription)
            .font(.body)
            .padding(.top, 10)
            .padding(.bottom, 30)
            .accessibilityIdentifier("descriptionLabel")
    }

    var attributionText: some View {
        Link(destination: URL(string: "http://marvel.com")!, label: {
            Text("Data provided by Marvel. © 2024 MARVEL")
        })

    }
}

#Preview {
    ComicView(viewModel: ComicViewModel(apiClient: ComicsService()))
}
