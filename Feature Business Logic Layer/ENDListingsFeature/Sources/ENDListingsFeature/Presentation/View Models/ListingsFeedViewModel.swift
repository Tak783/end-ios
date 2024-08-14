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
    public var onFeedLoadError: Observer<String?>?
    public var onFeedLoadSuccess: Observer<[ENDProductModel]>?
    
    public var title: String
    public var listingsFeedService: ListingsFeedServiceable

    public weak var coordinator: ListingsFeedCoordinating?
    public private (set) var feedItemPresentaionModels = [ENDProductPresentationModelling]()

    private var listingModels = [ENDProductModel]()
    
    public init(
        listingsFeedService: ListingsFeedServiceable,
        title: String,
        coordinator: ListingsFeedCoordinating?
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
                efficientPrint(error.localizedDescription)
                self.onFeedLoadError?("Failed to Load Feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
}

// MARK: - Load Listings Helpers
extension ListingsFeedViewModel {
    private func didLoadListings(_ listings: [ENDProductModel]) {
        listingModels = listings
        feedItemPresentaionModels = Self.adaptAccountToPresentationModels(
            for: listings
        )
        onFeedLoadError?(.none)
        onFeedLoadSuccess?(listings)
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
