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
        let remoteListingsFeedService = RemoteListingsFeedService(client: client)
        let (sut, _) = make_sut(listingsFeedService: remoteListingsFeedService, title: title)

        XCTAssertEqual(sut.title, title)
        XCTAssertNotNil(sut.accountsFeedService as? RemoteListingsFeedService)
    }
    
    func test_loadFeed_setsLoadStateToTrue() {
        
    }
    
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        
    }
    
    func test_loadFeed_triggersAPICall_whichOnError_returnsError() {
        
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
