//
//  ENDProductDetailPresentationModelling.swift
//
//
//  Created by Tak Mazarura on 15/08/2024.
//

import Foundation

public protocol ENDProductDetailPresentationModelling {
    var id: String { get }
    var name: String { get }
    var price: String { get }
    var imageURL: URL? { get }
}
