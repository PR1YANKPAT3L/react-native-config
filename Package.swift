// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/**
 
 The executables and libraries are separet into generated code and static code.
 
 To generate code change something in the `env.*.json` files and run the `Coder`.
 */

public struct External {
    public static let quickNimble: [Target.Dependency] = ["Quick", "Nimble"]
    public static let packages: [Package.Dependency] = [
        
        .package(url: "https://www.github.com/dooZdev/ZFile", "2.4.2" ..< "2.5.0"),
        .package(url: "https://www.github.com/dooZdev/Highway", "2.14.0" ..< "2.15.0"),
        
        // Quick & Nimble
        
        .package(url: "https://www.github.com/Quick/Quick", "1.3.4" ..< "2.1.0"),
        .package(url: "https://www.github.com/Quick/Nimble", "7.3.4" ..< "8.1.0"),
        
        // Sourcery
        
        .package(url: "https://www.github.com/doozMen/Sourcery", "0.17.0" ..< "0.18.0"),
        .package(url: "https://www.github.com/dooZdev/template-sourcery", "1.4.5" ..< "1.5.0"),
        
        // Logging
        
        .package(url: "https://www.github.com/doozMen/SignPost", "1.0.2" ..< "1.1.0"),
    ]
}

// MARK: - Generated

// MARK: - RNConfiguration

public struct Generated {
    /**
     This is the code generated for you by running RNConfigurationPrepare <#config#>
     This is the dependency you want to add to your project.
     */
    public struct RNConfiguration
    {
        public static let name = "\(Generated.RNConfiguration.self)"
        
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
                Target.Dependency(stringLiteral: Generated.RNConfiguration.Mock.name),
                ]
                + External.quickNimble
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
                Generated.RNConfiguration.target.dependencies
                    + [Target.Dependency(stringLiteral: library.name)],
                path: "Sources/Generated/\(library.name)"
            )
        }
    }
}


// MARK: - RNModels
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

// MARK: - RNModels
/**
 General models reused and separated to not create cyclic dependensies when generating RNConfiguration
 */
public struct CoderSecrets
{
    public static let name = "\(CoderSecrets.self)"
    
    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )
    
    public static let target = Target.target(
        name: name,
        dependencies: ["HighwayLibrary"]
    )
    
}

// MARK: - Coder
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
        dependencies: [Target.Dependency(stringLiteral: Library.library.name)]
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
            ["SignPost", "Terminal", "ZFile", "HighwayLibrary"]
                + [Target.Dependency(stringLiteral: RNModels.library.name)]
        )

        public static let tests = Target.testTarget(
            name: name + "Tests",
            dependencies:
            ["SignPostMock", "ZFileMock", "TerminalMock"]
                + [
                    Target.Dependency(stringLiteral: Generated.RNConfiguration.Mock.name),
                    Target.Dependency(stringLiteral: Coder.Library.Mock.name),
                    Target.Dependency(stringLiteral: RNModels.Mock.name)
                ]
                + [Target.Dependency(stringLiteral: name)]
                + External.quickNimble
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
                dependencies:
                Library.target.dependencies
                + [Target.Dependency(stringLiteral: Library.name)],
                path: "Sources/Generated/\(library.name)"
            )
        }
    }
}

// MARK: - Lanes
// MARK: - PrePushAndPR
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

// MARK: - CoderSourcery
/**
 Will run before pushing and in PR's on bitrise
 */
public struct CoderSourcery
{
    public static let name = "\(CoderSourcery.self)"
    
    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )
    
    public static let target = Target.target(
        name: name,
        dependencies: ["HighwayLibrary"]
    )
}


// MARK: - Examples

public struct Example {
    
    static let basePath = "Sources/Example/"
    
    /**
     Based on the configuration you build for different values will be printed. They are also available in JS and Android.
     
     ## setup
     
     ```swift
     swift build --product Coder --configuration release --static-swift-stdlib
     ./.build/x86_64-apple-macosx10.10/release/Coder
     open Coder.xcodeproj
     ```
     After this you will have have to run the Example executable scheme and take a look at terminal output.
     
     - warning: Before you run this from xcode you should setup the Coder by running it!
     - throws: when the xcodeconfig is loaded without a xcconfig file this code will not work and exit in failiure
     */
    public struct BuildConfiguration {
        
        public static let name = "\(BuildConfiguration.self)"
        
        public static let executable = Product.library(
            name: name,
            targets: [name]
        )
        
        public static let target = Target.target(
            name: name,
            dependencies: [Target.Dependency(stringLiteral: Generated.RNConfiguration.library.name)],
            path: basePath + name
        )
    }
    
}

// MARK: - Package

// MARK: - Product Package - react-native-config

let package = Package(
    name: "Coder",
    products: [
        Coder.executable,
        PrePushAndPR.executable,
        CoderSourcery.executable,
        Example.BuildConfiguration.executable,
        CoderSecrets.executable,

        RNModels.library,
        Generated.RNConfiguration.library,
        Coder.Library.library,

        RNModels.Mock.product,
        Generated.RNConfiguration.Mock.product,

    ],
    dependencies: External.packages,
    targets: [

        Coder.target,
        PrePushAndPR.target,
        CoderSourcery.target,
        Example.BuildConfiguration.target,
        CoderSecrets.target,

        Coder.Library.target,
        RNModels.target,
        Generated.RNConfiguration.target,

        Coder.Library.tests,
        Generated.RNConfiguration.tests,

        RNModels.Mock.target,
        Generated.RNConfiguration.Mock.target,
        Coder.Library.Mock.target,
    ]
)
