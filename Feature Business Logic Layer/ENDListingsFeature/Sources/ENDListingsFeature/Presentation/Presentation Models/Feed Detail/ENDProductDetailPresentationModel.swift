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
    
    public init(withListing listing: ENDProductModel) {
        self.id = listing.id
        self.name = listing.name.capitalized
        self.price = listing.price.capitalized
        self.imageURL = listing.imageURL
    }
}

// MARK: - ENDProductPresentationModelling
extension ENDProductPresentationModel: ENDProductDetailPresentationModelling {}

