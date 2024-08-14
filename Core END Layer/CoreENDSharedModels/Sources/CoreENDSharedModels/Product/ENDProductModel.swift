//
//  ENDProduct.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

public struct ENDProductModel: Equatable {
    public let id: String
    public let name: String
    public let price: String
    public let imageURL: String
    
    public init(
        id: String,
        name: String,
        price: String,
        imageURL: String) {
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
}

// MARK: - ENDProductModelling
extension ENDProductModel: ENDProductModelling {}
