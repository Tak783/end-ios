//
//  ListingsFeedViewModelUnitTests.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import XCTest
import CoreFoundational
import CoreNetworking
import CoreENDSharedModels
@testable import ENDListingsFeature
import MockNetworking

final class ListingsFeedViewModelUnitTests: ListingsFeedViewModelUnitTest {
    func test_init_setsInitialVariablesCorrectly() {
        let title = "Comme Des Garcons"
        let client = HTTPClientSpy()
        let remoteListingsFeedService = RemoteListingsFeedService(
            client: client
        )
        let (sut, _) = make_sut(
            listingsFeedService: remoteListingsFeedService, 
            title: title
        )

        XCTAssertEqual(sut.title, title)
        XCTAssertNotNil(sut.accountsFeedService as? RemoteListingsFeedService)
    }
    
    func test_loadFeed_setsLoadStateToTrue() {
        let client = HTTPClientSpy()
        let remoteListingsFeedService = RemoteListingsFeedService(
            client: client
        )
        let (sut, spy) = make_sut(
            listingsFeedService: remoteListingsFeedService
        )
        
        sut.loadFeed()

        XCTAssertEqual(spy.isLoading, true)
    }
    
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let client = HTTPClientSpy()
        let remoteListingsFeedService = RemoteListingsFeedService(
            client: client
        )
        let (sut, spy) = make_sut(
            listingsFeedService: remoteListingsFeedService
        )

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        
        client.complete(withStatusCode: 400, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        XCTAssertEqual(spy.isLoading, false)

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data())
        XCTAssertEqual(spy.isLoading, false)
    }
    
    func test_loadFeed_triggersAPICall_whichOnError_returnsError() {
        let client = HTTPClientSpy()
        let remoteListingsFeedService = RemoteListingsFeedService(
            client: client
        )
        let (sut, spy) = make_sut(
            listingsFeedService: remoteListingsFeedService
        )
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.loadFeed()
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }
    
    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsListings() {
        
    }
}

// MARK: - Make SUT
extension ListingsFeedViewModelUnitTests {
    private func make_sut(
        listingsFeedService: ListingsFeedServiceable,
        title: String = "Feed"
    ) -> (sut: ListingsFeedViewModel, spy: SpyListingsFeed) {
        let coordinator = SpyListingsCoordinator()
        let sut = ListingsFeedViewModel(
            accountsFeedService: listingsFeedService,
            title: title,
            coordinator: coordinator
        )
        trackForMemoryLeaks(sut)

        let spy = SpyListingsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
