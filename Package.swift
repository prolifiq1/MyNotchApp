// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MyNotchApp",
    platforms: [
        .macOS(.v15)
    ],
    targets: [
        .executableTarget(
            name: "MyNotchApp",
            path: "Sources/MyNotchApp"
        )
    ]
)
