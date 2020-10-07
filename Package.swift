// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PLogger",
    platforms: [ .macOS(.v10_10), .iOS(.v10), .tvOS(.v9), .watchOS(.v3)],
    products: [
        .library(name: "PLogger", targets: ["PLogger"])
    ],
    targets: [
        .target(name: "PLogger"),
        .testTarget(name: "PLoggerTests")
    ]
)
