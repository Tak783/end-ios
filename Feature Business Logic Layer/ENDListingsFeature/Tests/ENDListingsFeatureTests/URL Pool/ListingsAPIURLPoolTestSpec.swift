//
//  ListingsAPIURLPoolTestSpec.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import XCTest

typealias ListingsAPIURLPoolTests = XCTestCase & ListingsAPIURLPoolTestSpec

protocol ListingsAPIURLPoolTestSpec {
    func test_feedRequest_configuresFeedRequestCorrectly()
}
