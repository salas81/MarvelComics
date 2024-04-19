//
//  MarvelComicsUITests.swift
//  MarvelComicsUITests
//
//  Created by Lorenzo Decaria on 4/17/24.
//

import XCTest
@testable import MarvelComics

final class MarvelComicsUITests: XCTestCase {
    struct AccessibilityIdentifier {
        static let thumbnail = "thumbnail"
        static let titleLabel = "titleLabel"
        static let descriptionLabel = "descriptionLabel"
    }

    struct TestFailureMessage {
        static let thumbnailNotDisplayed = "Thumbnail is not displayed."
        static let titleLabelNotDisplayed = "Title label is not displayed."
        static let descriptionLabelNotDisplayed = "Description label is not displayed."
    }

    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testSuccessfulComic() throws {
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.titleLabel].waitForExistence(timeout: 5), TestFailureMessage.titleLabelNotDisplayed)
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.descriptionLabel].waitForExistence(timeout: 5), TestFailureMessage.descriptionLabelNotDisplayed)
    }
}
