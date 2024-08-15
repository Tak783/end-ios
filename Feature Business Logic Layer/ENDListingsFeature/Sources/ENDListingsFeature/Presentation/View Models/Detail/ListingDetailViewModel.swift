//
//  ListingDetailViewModel.swift
//
//
//  Created by Tak Mazarura on 15/08/2024.
//

import Foundation
import CoreENDSharedModels

public final class ListingDetailViewModel {
    public private (set) var presentationModel: ENDProductPresentationModelling
    
    private weak var coordinator: ListingsFeedCoordinating?
    private let listing: ENDProductModelling?

    public init(
        listing: ENDProductModel,
        coordinator: ListingsFeedCoordinating?
    ) {
        self.listing = listing
        self.coordinator = coordinator
        self.presentationModel = ENDProductPresentationModel(
            withListing: listing
        )
    }
}
