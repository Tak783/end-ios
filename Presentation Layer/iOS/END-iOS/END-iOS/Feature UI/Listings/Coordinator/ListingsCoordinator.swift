//
//  ListingsCoordinator.swift
//  END-iOS
//
//  Created by Tak Mazarura on 14/08/2024.
//

import UIKit
import CoreFoundational
import CoreENDSharedModels
import CoreNetworking
import CorePresentation
import ENDListingsFeature

final class ListingsCoordinator: ChildCoordinatorable, ParentCoordinatorable {
    var childCoordinators: [ChildCoordinatorable] = []
    let client: HTTPClient
    var router: Router
    var parentCoordinator: ParentCoordinatorable?
    
    init(
        router: Router,
        client: HTTPClient,
        parentCoordinator: ParentCoordinatorable?
    ) {
        self.router = router
        self.client = client
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        navigateToListingsFeed()
    }
    
    func didEnd(
        childCoordinator: CorePresentation.ChildCoordinatorable
    ) {
        efficientPrint("Did close Child Coordinator")
    }
}
 
// MARK: - ListingsFeedCoordinating
extension ListingsCoordinator: ListingsCoordinating {
    func navigateToListingsFeed() {
        let listingsFeedService = RemoteListingsFeedService(client: client)
        let accountsFeedViewController = ListingsFeedComposer.compose(
            with: listingsFeedService,
            title: "Listings",
            coordinator: self
        )
        router.navigateToViewController(accountsFeedViewController, withMethod: .push)
    }
    
    func navigateToListingDetail(
        forListing listing: ENDProductModel
    ) {
        let listingsFeedService = RemoteListingsFeedService(client: client)
        let accountsFeedViewController = ListingDetailComposer.compose(
            withListing: listing,
            coordinator: self
        )
        router.navigateToViewController(accountsFeedViewController, withMethod: .push)
    }
    
    func closeListingDetail() {
        router.popViewController()
    }
}
