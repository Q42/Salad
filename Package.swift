// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Salad",
  platforms: [.macOS(.v11), .iOS(.v13)],
  products: [
    .library(name: "Salad", targets: ["Salad"]),
  ],
  targets: [
    .target(name: "Salad", dependencies: []),
    .testTarget(name: "SaladTests", dependencies: ["Salad"]),
  ]
)
