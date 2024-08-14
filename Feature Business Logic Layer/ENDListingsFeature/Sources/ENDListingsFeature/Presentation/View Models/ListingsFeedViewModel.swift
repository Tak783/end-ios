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
    public var accountsFeedService: ListingsFeedServiceable

    public weak var coordinator: ListingsFeedCoordinating?
    public private (set) var feedItemViewModels = [ENDProductPresentationModelling]()

    private var listingModels = [ENDProductModel]()
    
    public init(
        accountsFeedService: ListingsFeedServiceable,
        title: String,
        coordinator: ListingsFeedCoordinating?
    ) {
        self.title = title
        self.accountsFeedService = accountsFeedService
        self.coordinator = coordinator
    }
}

// MARK: - ListingsFeedViewModelling
extension ListingsFeedViewModel: ListingsFeedViewModelling {
    public func loadFeed() {
        onLoadingStateChange?(true)
    }
}
