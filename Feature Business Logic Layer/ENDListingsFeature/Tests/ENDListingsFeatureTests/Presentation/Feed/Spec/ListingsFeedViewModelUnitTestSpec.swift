//
//  ListingsFeedViewModelUnitTestSpec.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import XCTest

protocol ListingsFeedViewModelUnitTestSpec {
    func test_init_setsInitialVariablesCorrectly()
    func test_loadFeed_setsLoadStateToTrue()
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse()
    func test_loadFeed_triggersAPICall_whichOnError_returnsError()
    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsListings()
}

typealias ListingsFeedViewModelIntegrationTest = XCTestCase & ListingsFeedViewModelUnitTestSpec
