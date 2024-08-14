//
//  ENDProduct.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation

public struct ENDProductModel: Equatable {
    public let id: String
    public let name: String
    public let price: String
    public let imageURL: URL
    
    public init(
        id: String,
        name: String,
        price: String,
        imageURL: URL
    ) {
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
}

// MARK: - ENDProductModelling
extension ENDProductModel: ENDProductModelling {}
