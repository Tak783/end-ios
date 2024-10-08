//
//  URLPoolTests.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreFoundational
import CoreNetworking
import CoreTesting
@testable import ENDListingsFeature
import XCTest

final class URLPoolUnitTests: ListingsAPIURLPoolTests {
    let expectedScheme = "https"
    let expectedHost = "endclothing.com"
    let defaultPath = "/media/catalog"

    override func setUp() {
        super.setUp()
        Self.resetUserDefaults()
    }
}
 
// MARK: - Test Feed
extension URLPoolUnitTests {
    func test_feedRequest_configuresFeedRequestCorrectly() {
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: "/example.json")
        let request = URLPool.listingsFeedRequest()
        
        assert(
            request: request,
            urlAbsoluteString: expectedUrlAbsoluteString,
            httpMethod: .get
        )
    }
}

// MARK: - Helpers
extension URLPoolUnitTests {
    private func fullURL(withPathSuffix pathSuffix: String) -> String {
        return expectedScheme + "://" + expectedHost + defaultPath + pathSuffix
    }
}

