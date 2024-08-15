//
//  ListingsFeedCoordinating.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreENDSharedModels

public protocol ListingsCoordinating: AnyObject {
    func navigateToListingsFeed()
    func navigateToListingDetail(
        forListing listing: ENDProductModel
    )
    func closeListingDetail()
}
