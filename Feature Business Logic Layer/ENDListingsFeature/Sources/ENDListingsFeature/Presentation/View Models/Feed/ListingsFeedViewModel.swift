//
//  ListingsFeedViewModel.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import CoreFoundational
import CoreENDSharedModels

public final class ListingsFeedViewModel {
    public var onLoadingStateChange: Observer<Bool>?
    public var onFeedLoadError: Observer<Void>?
    public var onFeedLoadSuccess: Observer<Void>?
    
    public private (set) var title: String
    public private (set) var feedItemPresentaionModels = [ENDProductPresentationModelling]()

    private let listingsFeedService: ListingsFeedServiceable
    private var listingModels = [ENDProductModel]()
    private weak var coordinator: ListingsCoordinating?

    public init(
        listingsFeedService: ListingsFeedServiceable,
        title: String,
        coordinator: ListingsCoordinating?
    ) {
        self.title = title
        self.listingsFeedService = listingsFeedService
        self.coordinator = coordinator
    }
}

// MARK: - ListingsFeedViewModelling
extension ListingsFeedViewModel: ListingsFeedViewModelling {
    public func loadFeed() {
        onLoadingStateChange?(true)
        listingsFeedService.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(listings):
                self.didLoadListings(listings)
            case .failure(let error):
                self.didFailToLoadListings(withError: error)
            }
            self.onLoadingStateChange?(false)
        }
    }
    
    public func didRequestToNavigateDetailForListing(
        atIndex index: Int
    ) {
        guard feedItemPresentaionModels.indices.contains(index) else {
            return
        }
        let listing = listingModels[index]
        coordinator?.navigateToListingDetail(forListing: listing)
    }
}

// MARK: - Load Listings Helpers
extension ListingsFeedViewModel {
    private func didLoadListings(_ listings: [ENDProductModel]) {
        listingModels = listings
        feedItemPresentaionModels = Self.adaptAccountToPresentationModels(
            for: listings
        )
        onFeedLoadSuccess?(())
    }
    
    private func didFailToLoadListings(withError error: Error) {
        efficientPrint(error.localizedDescription)
        onFeedLoadError?(())
    }
}

// MARK: - Adapt Listings models to Presentations Models
extension ListingsFeedViewModel {
    private static func adaptAccountToPresentationModels(
        for listings: [ENDProductModel]
    ) -> [ENDProductPresentationModelling] {
        return listings.map { listing in
            return ENDProductPresentationModel(
                withListing: listing
            )
        }
    }
}
