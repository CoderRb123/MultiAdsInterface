// swift-tools-version: 5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .package(name:"KeychainSwift",url: "https://github.com/evgenyneu/keychain-swift.git",.upToNextMajor(from: "24.0.0")),
        .package(
            name:"UserMessagingPlatform",
            url:"https://github.com/googleads/swift-package-manager-google-user-messaging-platform.git",
            branch: "main"
        ),
        
    ],
    targets: [
        .target(
            name: "MultiAdsInterface",
            dependencies: ["SwiftyJSON","IPAPI","KeychainSwift","UserMessagingPlatform"],
            path: "Sources"
        )

    ]
)
