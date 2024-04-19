//
//  MarvelComicsTests.swift
//  MarvelComicsTests
//
//  Created by Lorenzo Decaria on 4/17/24.
//

import XCTest
@testable import MarvelComics

final class MarvelComicsTests: XCTestCase {

    lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()

    lazy var apiClient: ComicsService = {
        ComicsService(urlSession: urlSession)
    }()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testSuccessfulComic() async throws {

        let mockData = StubbedComic.data

        MockURLProtocol.requestHandler = { request in 
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }

        let comic = try await apiClient.fetchComic(id: "1994")
        XCTAssertEqual(comic.title, "Official Handbook of the Marvel Universe (2004) #13 (TEAMS)")
        XCTAssertEqual(comic.textObjects.first?.text, "Heavy-hitting heroes unite! This Official Handbook contains in-depth bios on more than 30 of the Marvel Universe's most awesome assemblages - including the Defenders, Power Pack and the New Thunderbolts! Plus: An all-new cover by superstar artist Tom Grummett, digitally painted by Morry Hollowell.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
