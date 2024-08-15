//
//  ENDProductPresentationModelling.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation

public protocol ENDProductPresentationModelling {
    var id: String { get }
    var name: String { get }
    var price: String { get }
    var imageURL: URL? { get }
}
