//
//  RemoteListingsFeed.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation

struct RemoteListingsFeed: Decodable {
    let products: [RemoteENDProductModel]
}
