// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../RouterInterface"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: ["RouterInterface", "DesignSystem", "SnapKit"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "RouterInterface",
                .product(name: "RouterInterfaceTestHelpers", package: "RouterInterface")
            ]
        ),
    ]
)
