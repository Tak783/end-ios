//
//  ListingsFeedComposer.swift
//  END-iOS
//
//  Created by Tak Mazarura on 14/08/2024.
//

import UIKit
import CoreFoundational
import CoreENDSharedModels
import CoreNetworking
import CorePresentation
import ENDListingsFeature

final class ListingsFeedComposer {
    static func compose(
        with service: ListingsFeedServiceable,
        title: String,
        coordinator: ListingsCoordinating
    ) -> ListingsFeedViewController {
        let viewModel = ListingsFeedViewModel(
            listingsFeedService: service,
            title: title,
            coordinator: coordinator
        )
        let listingsFeedViewController = make(
            with: viewModel
        )
        return listingsFeedViewController
    }
}

// MARK: - Create Listings Feed View Controller
extension ListingsFeedComposer {
    private static func make(
        with viewModel: ListingsFeedViewModelling
    ) -> ListingsFeedViewController {
        let listingsFeedViewController = ListingsFeedViewController()
        listingsFeedViewController.feedViewModel = viewModel
        return listingsFeedViewController
    }
}
