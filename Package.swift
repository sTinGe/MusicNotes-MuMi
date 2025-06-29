// swift-tools-version:5.9
import PackageDescription

// This package is used to declare tool dependencies.
let package = Package(
    name: "MumiTools",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.55.1"),
    ]
)
