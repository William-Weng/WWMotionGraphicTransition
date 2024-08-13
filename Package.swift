// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWMotionGraphicTransition",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWMotionGraphicTransition", targets: ["WWMotionGraphicTransition"]),
    ],
    targets: [
        .target(name: "WWMotionGraphicTransition", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
