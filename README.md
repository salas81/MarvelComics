# MarvelComics

The app loads a comic id from Marvel's API and displays the tuhmbnail, title and description.

Built in SwiftUI with `MVVM` design pattern and `async/await` to handle network calls. Implementation is left simple and clean considering the time constraint for this project. Future improvement could include the use of `generics` in the network layer, to extend and reuse the existing code to fetch data from an end-point to fetch different entities from different end-points.

Also included one unit test and one UI test.

To run the app, navigate to the `Utils` folder and replace `static let PublicAPIKey = "YOUR PUBLIC KEY"` and `static let PrivateAPIKey = "YOUR PRIVATE KEY"` with your own keys.
