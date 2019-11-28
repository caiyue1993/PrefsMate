// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "PrefsMate",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "PrefsMate", targets: ["PrefsMate"])
    ],
    targets: [
        .target(
            name: "PrefsMate",
            path: "Source"
        )
    ]
)