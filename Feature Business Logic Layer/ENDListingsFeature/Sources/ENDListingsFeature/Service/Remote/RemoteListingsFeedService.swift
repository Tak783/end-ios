//
//  RemoteListingsFeedService.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import CoreFoundational
import CoreNetworking
import Foundation

public final class RemoteListingsFeedService: ListingsFeedServiceable {
    let client: HTTPClient
    
    public enum Error: Swift.Error {
        case invalidResponse
        case invalidData
    }
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load(
        completion: @escaping (ListingsFeedResult) -> Void
    ) {
        let request = URLPool.listingsFeedRequest()
        client.performRequest(request) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    if response.statusCode != 200 {
                        completion(.failure(Error.invalidResponse))
                    } else {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(
                            .jsonDateTimeFormatter
                        )
                        let feed = try decoder.decode(
                            RemoteListingsFeed.self,
                            from: data
                        )
                        completion(.success(feed.products.toModels()))
                    }
                } catch {
                    completion(.failure(Error.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
