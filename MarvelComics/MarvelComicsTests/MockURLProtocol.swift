//
//  MockURLProtocol.swift
//  MarvelComicsTests
//
//  Created by Lorenzo Decaria on 4/17/24.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No handler set")
            return
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            XCTFail("Error handling request")
        }
    }

    override func stopLoading() { }

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
}
