//
//  ListingsFeedViewModelling.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreFoundational
import Foundation

public protocol ListingsFeedViewModelling {
    var onLoadingStateChange: Observer<Bool>? { get set}
    var onFeedLoadError: Observer<Void>? { get set}
    var onFeedLoadSuccess: Observer<Void>? { get set}
    
    var title: String { get }
    var feedItemPresentaionModels: [ENDProductPresentationModelling] { get }
    
    func loadFeed()
    func didRequestToNavigateDetailForListing(atIndex index: Int)
}
