//
//  RemoteAccountsFeedServiceTestSpec.swift
//  
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import XCTest

protocol RemoteListingsFeedServiceTestSpec {
    func test_load_onSuccess_returnsListings()
    func test_load_onSuccessWithNon200Code_returnsError()
    func test_load_onSuccessWithNonInvalidData_returnsError()
    func test_load_onFailure_returnsError()
}

typealias RemoteListingsFeedServiceTests = XCTestCase & RemoteListingsFeedServiceTestSpec

