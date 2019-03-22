//
//  EnvironmentFiles.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import SignPost
import ZFile

public struct ConfigurationDisk {
    
    // MARK: - Variables
    
    public let inputJSON: Input
    public let environmentJsonFilesFolder: FolderProtocol
    public let rnConfigurationSourcesFolder: FolderProtocol
    public let androidFolder: FolderProtocol
    public let iosFolder: FolderProtocol
    
    public let iOS: Output
    public let android: Output
    
    public let code: Output.Code
    
    public let signPost: SignPostProtocol
    
    // MARK: - Enum

    public enum JSONFileName: String, CaseIterable {
        case debug = "env.debug.json"
        case release = "env.release.json"
        case local = "env.local.json"
        case betaRelease = "env.betaRelease.json"
    }
    
    // MARK: - Structs

    public struct Input {
        public let debug: FileProtocol
        public let release: FileProtocol
        public let local: FileProtocol?
        public let betaRelease: FileProtocol?
    }
    
    public struct Output {
        public let debug: FileProtocol
        public let release: FileProtocol
        public let local: FileProtocol?
        public let betaRelease: FileProtocol?
        
        public struct Code {
            public let rnConfigurationModelFactorySwiftFile: FileProtocol
            public let infoPlistRNConfiguration: FileProtocol
            public let infoPlistRNConfigurationTests: FileProtocol
            public let rnConfigurationModelSwiftFile: FileProtocol
            
            public func clearContentAllFiles() throws {
                try rnConfigurationModelFactorySwiftFile.write(string: """
                    import Foundation

                    /// ⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift
                    @objc public class RNConfigurationModelFactory: NSObject {
                    }
                """
                )
                try infoPlistRNConfiguration.write(string: """
                    <?xml version="1.0" encoding="UTF-8"?>
                    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
                    <plist version="1.0">
                    <dict>
                    <key>CFBundleDevelopmentRegion</key>
                        <string>$(DEVELOPMENT_LANGUAGE)</string>
                    <key>CFBundleExecutable</key>
                        <string>$(EXECUTABLE_NAME)</string>
                    <key>CFBundleIdentifier</key>
                        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
                    <key>CFBundleInfoDictionaryVersion</key>
                    <string>6.0</string>
                    <key>CFBundleName</key>
                        <string>$(PRODUCT_NAME)</string>
                    <key>CFBundlePackageType</key>
                        <string>FMWK</string>
                    <key>CFBundleShortVersionString</key>
                        <string>1.0</string>
                    <key>CFBundleVersion</key>
                        <string>$(CURRENT_PROJECT_VERSION)</string>
                    </dict>
                    </plist>

                """)
                try rnConfigurationModelSwiftFile.write(string: """
                    //⚠️ File is generated and ignored in git. To change it change /RNConfigurationHighwaySetup/main.swift

                    public struct RNConfigurationModel: Codable {
                    }
                """)
            }
        }
    }
    
    // MARK: - Init
    
    public init(rnConfigurationSrcRoot: FolderProtocol, environmentJsonFilesFolder: FolderProtocol, signPost: SignPostProtocol = SignPost.shared) throws {
        
        self.signPost = signPost
                
        var debugJSON: FileProtocol!
        var releaseJSON: FileProtocol!
        var localJSON: FileProtocol?
        var betaReleaseJSON: FileProtocol?
        
        debugJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.debug.rawValue)
        releaseJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.release.rawValue)
        do { localJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.local.rawValue) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationDisk.JSONFileName.local.rawValue) to have a local config. Ignoring for now") }
        do { betaReleaseJSON = try environmentJsonFilesFolder.file(named: ConfigurationDisk.JSONFileName.betaRelease.rawValue) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationDisk.JSONFileName.betaRelease.rawValue) to have a BetaRelease config. Ignoring for now") }
        
        rnConfigurationSourcesFolder = try rnConfigurationSrcRoot.subfolder(named: "Sources/RNConfiguration")
        
        self.inputJSON = Input(
            debug: debugJSON,
            release: releaseJSON,
            local: localJSON,
            betaRelease: betaReleaseJSON
        )
        
        self.androidFolder = try rnConfigurationSrcRoot.subfolder(named: "android")
        self.iosFolder = try rnConfigurationSrcRoot.subfolder(named: "ios")
        self.environmentJsonFilesFolder = rnConfigurationSrcRoot
        
        var localXconfigFile: FileProtocol?
        var localAndroidConfigurationFile: FileProtocol?
        var betaReleaseXconfigFile: FileProtocol?
        var betaReleaseAndroidConfigurationFile: FileProtocol?
        
        if localJSON != nil {
            localXconfigFile = try iosFolder.createFileIfNeeded(named: "Local.xcconfig")
            localAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.local")
        } else {
            localXconfigFile = nil
            localAndroidConfigurationFile = nil
        }
        
        if betaReleaseJSON != nil {
            betaReleaseXconfigFile = try iosFolder.createFileIfNeeded(named: "BetaRelease.xcconfig")
            betaReleaseAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.betaRelease")
        } else {
            betaReleaseXconfigFile = nil
            betaReleaseAndroidConfigurationFile = nil
        }
        
        iOS = Output(
            debug: try iosFolder.createFileIfNeeded(named: "Debug.xcconfig"),
            release: try iosFolder.createFileIfNeeded(named: "Release.xcconfig"),
            local: localXconfigFile,
            betaRelease: betaReleaseXconfigFile
        )
        
        android = Output(
            debug: try androidFolder.createFileIfNeeded(named: ".env.debug"),
            release: try androidFolder.createFileIfNeeded(named: ".env.release"),
            local: localAndroidConfigurationFile,
            betaRelease: betaReleaseAndroidConfigurationFile
        )
        
        code = Output.Code(
            rnConfigurationModelFactorySwiftFile: try rnConfigurationSourcesFolder.createFileIfNeeded(named: "RNConfigurationModelFactory.swift"),
            infoPlistRNConfiguration: try rnConfigurationSrcRoot.createFileIfNeeded(named: "RNConfigurationHighwaySetup.xcodeproj/RNConfiguration_Info.plist"),
            infoPlistRNConfigurationTests: try rnConfigurationSrcRoot.createFileIfNeeded(named: "RNConfigurationHighwaySetup.xcodeproj/RNConfigurationTests_Info.plist"),
            rnConfigurationModelSwiftFile: try rnConfigurationSourcesFolder.createFileIfNeeded(named: "RNConfigurationModel.swift")
        )
        
    }
    
}
