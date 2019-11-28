// swift-tools-version:5.1

let package = Package(
    name: "PrefsMate",
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