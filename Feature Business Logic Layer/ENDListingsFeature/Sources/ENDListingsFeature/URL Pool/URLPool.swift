//
//  URLPool.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreFoundational
import CoreNetworking
import Foundation

// MARK: - URL Components
extension URLPool {
    private static let scheme = "https"
    private static let host = "endclothing.com"
    private static let path = "/media/catalog/"
    
    private enum EndPoints: String {
        case listingsFeed = "example.json"
    }
}

// MARK: - Requests
extension URLPool: ListingsAPIURLPoolable {
    static func listingsFeedRequest() -> URLRequest  {
        let endPoint = path + EndPoints.listingsFeed.rawValue
        let url = configureURL(scheme: scheme, host: host, path: endPoint)
        let request = URLRequest.init(method: .get, url: url)
        return request
    }
}
