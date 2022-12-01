// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "AdventOfCode2022", targets: ["AdventOfCode2022"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        .target(name: "AdventOfCode2022", dependencies: [.product(name: "Algorithms", package: "swift-algorithms")]),
        .testTarget(name: "AdventOfCode2022Tests", dependencies: ["AdventOfCode2022"])
    ]
)
