//
//  ENDProductDetailPresentationModel.swift
//
//
//  Created by Tak Mazarura on 15/08/2024.
//

import Foundation
import CoreENDSharedModels

public struct ENDProductDetailPresentationModel {
    public private (set) var id: String
    public private (set) var name: String
    public private (set) var price: String
    public private (set) var imageURL: URL?
    
    public init(withListing listing: ENDProductModelling) {
        self.id = listing.id
        self.name = listing.name.uppercased()
        self.price = listing.price.uppercased()
        self.imageURL = listing.imageURL
    }
}

// MARK: - ENDProductPresentationModelling
extension ENDProductDetailPresentationModel: ENDProductDetailPresentationModelling {}

