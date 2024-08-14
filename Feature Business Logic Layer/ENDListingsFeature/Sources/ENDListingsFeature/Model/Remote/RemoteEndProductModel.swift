//
//  RemoteEndProductModel.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation

public struct RemoteENDProductModel {
    public let id: String
    public let name: String
    public let price: String
    public let image: String
    
    public init(
        id: String,
        name: String,
        price: String,
        image: String
    ) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
}

// MARK: - Decodable
extension ENDProduct: Decodable {
    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case image
    }
}

// MARK: - ENDProductModelling
extension ENDProduct: ENDProductModelling {}
