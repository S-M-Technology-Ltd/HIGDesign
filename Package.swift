// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "HIGDesign",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .visionOS(.v2),
        .tvOS(.v18),
        .watchOS(.v11),
    ],
    products: [
        .library(name: "HIGDesign", targets: ["HIGDesign"]),
        .library(name: "HIGDesignCore", targets: [
            "HIGFoundations",
            "HIGTokensRaw",
            "HIGTokensSemantic",
            "HIGTokensComponent",
            "HIGThemesContract",
            "HIGThemesSystem",
        ]),
        .library(name: "HIGDesignComponents", targets: [
            "HIGComponents",
            "HIGModifiers",
        ]),
        .library(name: "HIGDesignPlatform", targets: ["HIGPlatform"]),
    ],
    targets: [
        .target(name: "HIGFoundations", path: "Sources/HIGFoundations"),
        .target(name: "HIGTokensRaw", dependencies: ["HIGFoundations"], path: "Sources/HIGTokensRaw"),
        .target(
            name: "HIGTokensSemantic",
            dependencies: ["HIGTokensRaw"],
            path: "Sources/HIGTokensSemantic"
        ),
        .target(
            name: "HIGTokensComponent",
            dependencies: ["HIGTokensSemantic"],
            path: "Sources/HIGTokensComponent"
        ),
        .target(
            name: "HIGThemesContract",
            dependencies: ["HIGTokensComponent", "HIGFoundations"],
            path: "Sources/HIGThemesContract"
        ),
        .target(
            name: "HIGThemesSystem",
            dependencies: ["HIGThemesContract"],
            path: "Sources/HIGThemesSystem"
        ),
        .target(
            name: "HIGPlatform",
            dependencies: ["HIGFoundations"],
            path: "Sources/HIGPlatform"
        ),
        .target(
            name: "HIGComponents",
            dependencies: [
                "HIGThemesContract",
                "HIGPlatform",
                "HIGTokensSemantic",
                "HIGTokensComponent",
            ],
            path: "Sources/HIGComponents"
        ),
        .target(
            name: "HIGModifiers",
            dependencies: ["HIGThemesContract"],
            path: "Sources/HIGModifiers"
        ),
        .target(
            name: "HIGDesign",
            dependencies: [
                "HIGFoundations",
                "HIGTokensRaw",
                "HIGTokensSemantic",
                "HIGTokensComponent",
                "HIGThemesContract",
                "HIGThemesSystem",
                "HIGPlatform",
                "HIGComponents",
                "HIGModifiers",
            ],
            path: "Sources/HIGDesign"
        ),
        .testTarget(
            name: "HIGDesignTests",
            dependencies: [
                "HIGTokensRaw",
                "HIGTokensSemantic",
                "HIGThemesSystem",
                "HIGComponents",
            ],
            path: "Tests/HIGDesignTests"
        ),
    ],
    swiftLanguageModes: [.v6]
)