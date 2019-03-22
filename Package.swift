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
        ),
        .library(
            name: "RNConfiguration",
            targets: ["RNConfiguration"]
        ),
        
        // MARK: - Mocks
        .library(
                name: "RNConfigurationPrepareMock",
                targets: ["RNConfigurationPrepareMock"]
        ),
        .library(
            name: "RNModelsMock",
            targets: ["RNModelsMock"]
        ),
        .library(
            name: "RNConfigurationMock",
            targets: ["RNConfigurationMock"]
        ),
        
    ],
    dependencies: [
        
        // MARK: - External Dependencies
        
        // MARK: - Highway
        
        .package(url: "https://www.github.com/Bolides/ZFile", "2.4.1" ..< "3.0.0"),
        .package(url: "https://www.github.com/Bolides/Highway", "2.6.19" ..< "3.0.0"),

        // MARK: - Quick & Nimble
        
        .package(url: "https://www.github.com/Quick/Quick", "1.3.4" ..< "2.1.0"),
        .package(url: "https://www.github.com/Quick/Nimble", "7.3.4" ..< "8.1.0"),
        
        // MARK: - Sourcery
        
        .package(url: "https://www.github.com/doozMen/Sourcery", "0.16.3" ..< "1.0.0"),
        .package(url: "https://www.github.com/dooZdev/template-sourcery", "1.4.3" ..< "2.0.0"),
        
        // MARK: - Logging
        
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
                "RNConfigurationPrepare",
                "SourceryWorker",
                "ZFile"
            ]
        ),
        .target(
            name: "RNConfigurationPrepare",
            dependencies: ["RNModels", "ZFile", "Terminal", "XCBuild", "SignPost"]
        ),
        .target(
            name: "RNModels",
            dependencies: []
        ),
        .target(
            name: "RNConfiguration",
            dependencies: ["RNModels"]
        ),
        
        // MARK: - Test
        
        .testTarget(
            name: "RNConfigurationHighwaySetupTests",
            dependencies: ["RNConfigurationHighwaySetup", "Quick", "Nimble", "SignPostMock", "ZFileMock"]
        ),
        .testTarget(
            name: "RNConfigurationTests",
            dependencies: ["RNConfiguration", "Quick", "Nimble"]
        ),
        
        // MARK: - Mock target
        
        .target(
            name: "RNConfigurationPrepareMock",
            dependencies: ["RNConfigurationPrepare", "SignPost", "SourceryAutoProtocols"],
            path: "Sources/Generated/RNConfigurationPrepare"
        ),
        .target(
            name: "RNModelsMock",
            dependencies: ["RNModels", "SignPost", "SourceryAutoProtocols"],
            path: "Sources/Generated/RNModels"
        ),
        .target(
            name: "RNConfigurationMock",
            dependencies: ["RNConfiguration", "SignPost", "SourceryAutoProtocols"],
            path: "Sources/Generated/RNConfiguration"
        ),
        
    ]
)
