//
//  SpyListingsCoordinator.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import ENDListingsFeature
import CoreENDSharedModels

final class SpyListingsCoordinator: ListingsCoordinating {
    var didNavigateToListingsFeed = false
    var didNavigateToListingsDetail = false
    var didNavigateBackFromListingDetail = false
    
    func navigateToListingsFeed() {
        didNavigateToListingsFeed = true
    }
    
    func navigateToListingDetail(
        forListing listing: ENDProductModel
    ) {
        didNavigateToListingsDetail = true
    }
    
    func closeListingDetail() {
        didNavigateBackFromListingDetail = true
    }
}
