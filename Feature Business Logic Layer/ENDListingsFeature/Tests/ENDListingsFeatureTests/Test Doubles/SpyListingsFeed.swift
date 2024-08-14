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
    var isLoading: Bool = false
    var error: String?
    var listings: [ENDProductModel]?

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

        viewModel.onFeedLoadError = { [weak self] error in
            guard let self = self else { return }
            self.error = error
        }

        viewModel.onFeedLoadSuccess = { [weak self] listings in
            guard let self = self else { return }
            self.listings = listings
        }
    }
}
