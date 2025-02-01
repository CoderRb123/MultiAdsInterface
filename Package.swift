// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MultiAdsInterface",
    products: [
        .library(
            name: "MultiAdsInterface",
            targets: ["MultiAdsInterface"]),
        
    ],
    dependencies : [
        .package(name:"SwiftyJSON",url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.2")),
        .package(name:"IPAPI",url: "https://github.com/arturgrigor/IPAPI.git",.upToNextMajor(from: "3.0.0")),
        .package(name:"KeychainSwift",url: "https://github.com/evgenyneu/keychain-swift.git",.upToNextMajor(from: "24.0.0"))
        
    ],
    targets: [
        .target(
            name: "MultiAdsInterface",
            dependencies: ["SwiftyJSON","IPAPI","KeychainSwift",.byName(name: "UserMessagingPlatformDep")],
            path: "Sources/"
        ),
        .binaryTarget(
         name: "UserMessagingPlatformDep",
         path: "./Sources/UserMessagingPlatform.xcframework"),

    ]
)
