//
//  ListingDetailComposer.swift
//  END-iOS
//
//  Created by Tak Mazarura on 15/08/2024.
//

import UIKit
import CoreFoundational
import CoreENDSharedModels
import CoreNetworking
import CorePresentation
import ENDListingsFeature

final class ListingDetailComposer {
    static func compose(
        withListing listing: ENDProductModelling,
        coordinator: ListingsCoordinating
    ) -> ListingDetailViewController {
        let viewModel = ListingDetailViewModel(
            listing: listing,
            coordinator: coordinator
        )
        let detailViewController = make(
            with: viewModel
        )
        return detailViewController
    }
}

// MARK: - Create Listings Detail View Controller
extension ListingDetailComposer {
    private static func make(
        with viewModel: ListingDetailViewModelling
    ) -> ListingDetailViewController {
        let listingDetailViewController = ListingDetailViewController()
        listingDetailViewController.feedViewModel = viewModel
        return listingDetailViewController
    }
}

