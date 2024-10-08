//
//  ENDProductPresentationModel.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import CoreENDSharedModels

public struct ENDProductPresentationModel {
    public private (set) var id: String
    public private (set) var name: String
    public private (set) var price: String
    public private (set) var imageURL: URL?
    
    public init(withListing listing: ENDProductModelling) {
        self.id = listing.id
        self.name = listing.name
        self.price = listing.price
        self.imageURL = listing.imageURL
    }
}

// MARK: - ENDProductPresentationModelling
extension ENDProductPresentationModel: ENDProductPresentationModelling {}
