// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let apple = "https://github.com/apple/"

let package = Package(
    name: "search-algorithms",
    products: [
        .library(name: "Algorithms", targets: ["Algorithms"]),
        .library(name: "PuzzleDomain", targets: ["PuzzleDomain"]),
        .library(name: "PuzzleRulesets", targets: ["PuzzleRulesets"]),
        .library(name: "PuzzleSearch", targets: ["PuzzleSearch"]),
        .library(name: "Presentation", targets: ["Presentation"])
    ],
    dependencies: [
        .package(url: apple + "swift-collections", from: "1.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Benchmark",
            dependencies: [
                "Algorithms",
                "Presentation",
                "PuzzleDomain",
                "PuzzleRulesets",
                "PuzzleSearch"
            ]
        ),
        .executableTarget(
            name: "Demo",
            dependencies: [
                "Algorithms",
                "Presentation",
                "PuzzleDomain",
                "PuzzleRulesets",
                "PuzzleSearch"
            ]
        ),
        .target(
            name: "Algorithms",
            dependencies: [
                .product(name: "DequeModule", package: "swift-collections"),
                .product(name: "HeapModule", package: "swift-collections")
            ]
        ),
        .target(
            name: "NibblePacking"
        ),
        .target(
            name: "Presentation",
            dependencies: ["PuzzleRulesets"]
        ),
        .target(
            name: "PuzzleDomain"
        ),
        .target(
            name: "PuzzleRulesets",
            dependencies: [
                "PuzzleDomain",
                "NibblePacking"
            ]
        ),
        .target(
            name: "PuzzleSearch",
            dependencies: [
                "Algorithms",
                "NibblePacking",
                "PuzzleDomain",
                "PuzzleRulesets"
            ]
        ),
        .target(
            name: "CustomTags",
            path: "Tests/Support/CustomTags"
        ),
        .target(
            name: "RulesetSpecification",
            dependencies: ["PuzzleDomain", "PuzzleRulesets"],
            path: "Tests/Support/RulesetSpecification",
        ),
        .testTarget(
            name: "AlgorithmsTests",
            dependencies: ["Algorithms", "CustomTags"]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation", "CustomTags"]
        ),
        .testTarget(
            name: "PuzzleRulesetsTests",
            dependencies: [
                "PuzzleRulesets",
                "CustomTags",
                "RulesetSpecification"
            ]
        ),
        .testTarget(
            name: "PuzzleSearchTests",
            dependencies: [
                "PuzzleSearch",
                "CustomTags",
                "RulesetSpecification"
            ]
        )
    ]
)
