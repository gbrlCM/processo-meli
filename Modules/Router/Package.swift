// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Router",
            targets: ["Router"]),
    ],
    dependencies: [
        .package(path: "../Model"),
        .package(path: "../Home"),
        .package(path: "../Detail"),
        .package(path: "../Search"),
        .package(path: "../Network"),
        .package(path: "../RouterInterface")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Router", dependencies: ["Model", "Home", "Detail", "Search", "RouterInterface", "Network"]),
        .testTarget(
            name: "RouterTests",
            dependencies: ["Router", "Model", "RouterInterface"]
        ),
    ]
)
