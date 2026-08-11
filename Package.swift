// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "Geometry",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .tvOS(.v14)
    ],
    products: [
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
        .package(url: "https://github.com/apple/swift-numerics.git", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.0")
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
            ],
            exclude: ["__Snapshots__"]
        ),
        // MARK: SpriteKitSupport
        .target(
            name: "GeometrySpriteKitExtensions",
            dependencies: ["Geometry"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
