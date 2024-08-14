//
//  ListingsFeedServiceable.swift
//  
//
//  Created by Tak Mazarura on 14/08/2024.
//

import Foundation
import CoreENDSharedModels

public protocol ListingsFeedServiceable: AnyObject  {
    typealias ListingsFeedResult = Swift.Result<[ENDProductModel], Error>

    func load(completion: @escaping (ListingsFeedResult) -> Void)
}
