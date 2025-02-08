// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Search",
            targets: ["Search"]),
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../Model"),
        .package(path: "../Network"),
        .package(path: "../RouterInterface"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Search",
            dependencies: ["DesignSystem", "Model", "SnapKit", "Network", "RouterInterface"]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: ["Search", "DesignSystem", "Model", "SnapKit", "Network", "RouterInterface"]
        ),
    ]
)
