//
//  RemoteEndProductModel.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreENDSharedModels
import Foundation

public struct RemoteENDProductModel {
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

// MARK: - Decodable
extension RemoteENDProductModel: Decodable {
    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case imageURL = "image"
    }
}

// MARK: - ENDProductModelling
extension RemoteENDProductModel: ENDProductModelling {}

// MARK: - To production model
extension RemoteENDProductModel {
    func toModel() -> ENDProductModel {
        ENDProductModel(
            id: id,
            name: name,
            price: price,
            imageURL: imageURL
        )
    }
}

// MARK: - To production models array
extension Array where Element == RemoteENDProductModel {
    func toModels() -> [ENDProductModel] {
        self.compactMap {
            $0.toModel()
        }
    }
}
