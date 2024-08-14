//
//  ListingsAPIURLPoolable.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation

protocol ListingsAPIURLPoolable {
    static func listingsFeedRequest() -> URLRequest
}
