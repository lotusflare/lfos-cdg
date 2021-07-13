// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreDataGenerator",
    platforms: [.iOS(.v11),
                .macOS(.v10_13)],
    products: [
        .library(
            name: "CoreDataGenerator",
            targets: ["CoreDataGenerator"]),
    ],
    targets: [
        .target(
            name: "CoreDataGenerator",
            path: "CoreDataGenerator/CoreDataGenerator")
    ]
)
