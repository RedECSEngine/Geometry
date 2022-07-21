// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Geometry",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Geometry",
            targets: ["Geometry"]
        ),
        .library(
            name: "GeometryAlgorithms",
            targets: ["GeometryAlgorithms"]
        ),
        .library(
            name: "GeometrySpriteKitExtensions",
            targets: ["GeometrySpriteKitExtensions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics.git", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0")
    ],
    targets: [
        // MARK: Geometry
        .target(
            name: "Geometry",
            dependencies: []
        ),
        .testTarget(
            name: "GeometryTests",
            dependencies: ["Geometry", "GeometrySpriteKitExtensions"]
        ),
        // MARK: Algorithms
        .target(
            name: "GeometryAlgorithms",
            dependencies: ["Geometry", .product(name: "RealModule", package: "swift-numerics")]
        ),
        .testTarget(
            name: "GeometryAlgorithmsTests",
            dependencies: [
                "Geometry",
                "GeometryAlgorithms",
                "GeometrySpriteKitExtensions",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),
        // MARK: SpriteKitSupport
        .target(
            name: "GeometrySpriteKitExtensions",
            dependencies: ["Geometry"]
        ),
    ]
)
