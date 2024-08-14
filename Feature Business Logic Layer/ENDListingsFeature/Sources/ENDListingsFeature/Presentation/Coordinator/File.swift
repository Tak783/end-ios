//
//  ListingsFeedCoordinating.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreENDSharedModels

public protocol ListingsFeedCoordinating: AnyObject {
    func navigateToListingsFeed()
    func navigateToListingDetail(
        forListing listing: ENDProductModelling
    )
}
