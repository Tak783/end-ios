//
//  AppLaunchCoordinator.swift
//  END-iOS
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreFoundational
import CoreNetworking
import CorePresentation
import ENDListingsFeature
import UIKit

final class AppLaunchCoordinator {
    var router: Router
    var childCoordinators = [ChildCoordinatorable]()
    let client: HTTPClient
    
    init(
        router: Router,
        client: HTTPClient
    ) {
        self.router = router
        self.client = client
    }
    
    func start() {
        navigateToListingsFeed()
    }
    
    func didEnd(
        childCoordinator: ChildCoordinatorable
    ) {
        efficientPrint("Did close parent coordinator")
    }
}

// MARK: - ParentCoordinatorable
extension AppLaunchCoordinator: ParentCoordinatorable {
    func navigateToListingsFeed() {
        let listingsCoordinator = ListingsCoordinator(
            router: router,
            client: client,
            parentCoordinator: self
        )
        addChildCoordinator(
            coordinator: listingsCoordinator
        )
        listingsCoordinator.start()
    }
}
