//
//  ENDProduct.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

public struct ENDProductModel {
    public let id: String
    public let name: String
    public let price: String
    public let image: String
    
    public init(
        id: String,
        name: String,
        price: String,
        image: String) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
}

// MARK: - ENDProductModelling
extension ENDProductModel: ENDProductModelling {}
