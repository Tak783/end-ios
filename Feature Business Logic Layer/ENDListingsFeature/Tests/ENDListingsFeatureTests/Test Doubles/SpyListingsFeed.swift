//
//  SpyListingsFeed.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreENDSharedModels
import ENDListingsFeature
import Foundation

final class SpyListingsFeed: NSObject {
    var isLoading = false
    var didFailToLoadFeed = false
    var didSuccessfullyLoadFeed = false

    var viewModel: ListingsFeedViewModel

    init(viewModel: ListingsFeedViewModel) {
        self.viewModel = viewModel
        super.init()

        bind()
    }

    func bind() {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            self.isLoading = isLoading
        }

        viewModel.onFeedLoadError = { [weak self] _ in
            guard let self = self else { return }
            self.didFailToLoadFeed = true
        }

        viewModel.onFeedLoadSuccess = { [weak self] _ in
            guard let self = self else { return }
            self.didSuccessfullyLoadFeed = true
        }
    }
}
