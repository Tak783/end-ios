// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ENDListingsFeature",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ENDListingsFeature",
            targets: ["ENDListingsFeature"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CoreTesting",
            path: "../Core Layer/CoreTesting"
        ),
        .package(
            name: "CoreNetworking",
            path: "../Core Shared Components Layer/CoreNetworking"
        ),
        .package(
            name: "MockNetworking",
            path: "../Core Shared Components Layer/MockNetworking"
        ),
        .package(
            name: "CoreStarlingEngineSharedModels",
            path: "../Core Starling Engine Layer/CoreStarlingEngineSharedModels"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ENDListingsFeature",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreNetworking",
                    package: "CoreNetworking"
                ),
                .product(
                    name: "CoreStarlingEngineSharedModels",
                    package: "CoreStarlingEngineSharedModels"
                )
            ]
        ),
        .testTarget(
            name: "ENDListingsFeatureTests",
            dependencies: [
                "ENDListingsFeature",
                .product(
                    name: "CoreTesting",
                    package: "CoreTesting"
                ),
                .product(
                    name: "MockNetworking",
                    package: "MockNetworking"
                )
            ]
        ),
    ]
)
