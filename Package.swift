// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "AdventOfCode2022", targets: ["AdventOfCode2022"])
    ],
    targets: [
        .target(name: "AdventOfCode2022", dependencies: []),
        .testTarget(name: "AdventOfCode2022Tests", dependencies: ["AdventOfCode2022"])
    ]
)
