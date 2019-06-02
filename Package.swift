// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Exteranal

let quickNimble: [Target.Dependency] = ["Quick", "Nimble"]

// MARK: - Libraries and executables

/**
 This is the code generated for you by running RNConfigurationPrepare <#config#>
 This is the dependency you want to add to your project.
 */
public struct RNConfiguration
{
    public static let name = "\(RNConfiguration.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["RNModels", "SourceryAutoProtocols"]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [
            Target.Dependency(stringLiteral: name),
            Target.Dependency(stringLiteral: RNConfiguration.Mock.name),
        ]
            + quickNimble
    )

    public struct Mock
    {
        public static let name = library.name + "Mock"

        public static let product = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            RNConfiguration.target.dependencies
                + [Target.Dependency(stringLiteral: library.name)],
            path: "Sources/Generated/\(library.name)"
        )
    }
}

/**
 It writes the env.*.json files into code for ios, android and JS
 */
public struct Coder
{
    public static let name = "\(Coder.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [
            "SignPost",
            "HighwayLibrary",
            "SourceryAutoProtocols",
            "SourceryWorker",
            "ZFile",
        ]
            + [Target.Dependency(stringLiteral: Library.library.name)]
    )

    public struct Library
    {
        public static let name = executable.name + "Library"

        public static let library = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            ["SignPost", "Terminal"]
                + [Target.Dependency(stringLiteral: RNModels.library.name)]
        )

        public static let tests = Target.testTarget(
            name: name + "Tests",
            dependencies:
            ["SignPostMock", "ZFileMock", "TerminalMock"]
                + ["ZFile"]
                + [
                    Target.Dependency(stringLiteral: name),
                    Target.Dependency(stringLiteral: RNConfiguration.Mock.name),
                ]
                + quickNimble
        )

        public struct Mock
        {
            public static let name = Library.name + "Mock"

            public static let product = Product.library(
                name: name,
                targets: [name]
            )

            public static let target = Target.target(
                name: name,
                dependencies: [],
                path: "Sources/Generated/\(library.name)"
            )
        }
    }
}

/**
 Will run before pushing and in PR's on bitrise
 */
public struct PrePushAndPR
{
    public static let name = "\(PrePushAndPR.self)"
    
    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )
    
    public static let target = Target.target(
        name: name,
        dependencies: ["HighwayLibrary"]
    )
}
/**
 General models reused and separated to not create cyclic dependensies when generating RNConfiguration
 */
public struct RNModels
{
    public static let name = "\(RNModels.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["SourceryAutoProtocols"]
    )

    public struct Mock
    {
        public static let name = library.name + "Mock"

        public static let product = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            RNModels.target.dependencies
                + [Target.Dependency(stringLiteral: library.name)],
            path: "Sources/Generated/\(library.name)"
        )
    }
}

// MARK: - Package

let package = Package(
    name: "react-native-config",
    products: [
        // MARK: - Executable

        Coder.executable,
        PrePushAndPR.executable,

        // MARK: - Library

        RNModels.library,
        RNConfiguration.library,
        Coder.Library.library,

        // MARK: - Mocks

        RNModels.Mock.product,
        RNConfiguration.Mock.product,

    ],
    dependencies: [
        // MARK: - External Dependencies

        // MARK: - Highway

        .package(url: "https://www.github.com/dooZdev/ZFile", "2.4.2" ..< "3.0.0"),
        .package(url: "https://www.github.com/dooZdev/Highway", "2.11.11" ..< "3.0.0"),

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
        // MARK: - executable

        Coder.target,
        PrePushAndPR.target,

        // MARK: - Library

        Coder.Library.target,
        RNModels.target,
        RNConfiguration.target,

        // MARK: - Test

        Coder.Library.tests,
        RNConfiguration.tests,

        // MARK: - Mock target

        RNModels.Mock.target,
        RNConfiguration.Mock.target,
        Coder.Library.Mock.target,
    ]
)
