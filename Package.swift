// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RNConfigurationHighwaySetup",
    products: [
        
        // MARK: - Executable
        
        .executable(
            name: "RNConfigurationHighwaySetup",
            targets: ["RNConfigurationHighwaySetup"]),
        
        // MARK: - Library
        
        .library(
            name: "RNConfigurationPrepare",
            targets: ["RNConfigurationPrepare"]
        ),
        .library(
            name: "RNModels",
            targets: ["RNModels"]
        )
    ],
    dependencies: [
        
        // MARK: - External Dependencies
        
        .package(url: "https://www.github.com/Bolides/Highway", "2.5.1" ..< "3.0.0"),
        .package(url: "https://www.github.com/Quick/Quick", "1.3.4" ..< "2.1.0"),
        .package(url: "https://www.github.com/Quick/Nimble", "7.3.4" ..< "8.1.0"),
        .package(url: "https://www.github.com/dooZdev/template-sourcery", "1.3.7" ..< "2.0.0"),
        .package(url: "https://www.github.com/doozMen/Sourcery", "0.16.3" ..< "1.0.0"),
        .package(url: "https://www.github.com/doozMen/SignPost", "1.0.0" ..< "2.0.0"),
    ],
    targets: [

        // MARK: - Target
        
        .target(
            name: "RNConfigurationHighwaySetup",
            dependencies: [
                "SignPost",
                "Highway",
                "SourceryAutoProtocols",
                "RNConfigurationPrepare"
            ]
        ),
        .target(
            name: "RNConfigurationPrepare",
            dependencies: ["RNModels"]
        ),
        .target(
            name: "RNModels",
            dependencies: [],
            path: "ios/Sources/RNModels"
        ),
        
        // MARK: - Test
        
        .testTarget(
            name: "RNConfigurationHighwaySetupTests",
            dependencies: ["RNConfigurationHighwaySetup", "Quick", "Nimble"]),
    ]
)
