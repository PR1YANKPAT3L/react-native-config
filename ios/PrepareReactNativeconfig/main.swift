//
//  main.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 29/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import ZFile
import SignPost

let currentFolder = FileSystem.shared.currentFolder

enum Error: Swift.Error {
    case noPrepareInSwiftFile
    case missingIOSFolder
}

let signPost = SignPost.shared
signPost.message("🚀 ReactNativeConfig main.swift\nExecuted at path \(currentFolder.path)\n...")

do {
    
    let configurationFiles = try ConfigurationFiles(reactNativeFolder: try currentFolder.parentFolder())
    
    let configurations = try writeToPlatformReadableConfiguarationFiles(from: configurationFiles)
    
    SignPost.shared.message("""
        🚀 Env read from
            \(configurationFiles.debugJSONfile)
            \(configurationFiles.releaseJSONfile)
            \(String(describing: configurationFiles.localJSONfile))
         ...
        """
    )
    
    SignPost.shared.message("""
        🚀 Written to config files
        # ios
            \(configurationFiles.debugXconfigFile)
            \(configurationFiles.releaseXconfigFile)
            \(String(describing: configurationFiles.localXconfigFile))
        # android
            \(configurationFiles.debugAndroidConfigurationFile)
            \(configurationFiles.releaseAndroidConfigurationFile)
            \(String(describing: configurationFiles.localAndroidConfigurationFile))
        ...
        """
    )
    
    // iOS
    // Only 1 environment read is good. Values come form configuration files
    
    
    
    let allCases: String = text
        .map { $0.case }
        .map {"      \($0)"}
        .joined(separator: "\n")
    
    SignPost.shared.verbose("Writing environment variables to swift files and plist")
    try generateConfigurationWorker(allCases: allCases, configurationFiles: configurationFiles)
   
    let plistVar: String = text
        .map { $0.plistVar }
        .map {"    \($0)"}
        .joined(separator: "\n")
    let plistVarString: String = text
        .map { $0.plistVarString }
        .map { "            * \($0)" }
        .joined(separator: "\n")
    
    let plistLinesSwift = """
    //
    //  Configuration.swift
    //  ReactNativeConfigSwift
    //
    //  Created by Stijn on 30/01/2019.
    //  Copyright © 2019 Pedro Belo. All rights reserved.
    //

    import Foundation

    //⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift

    public struct Configuration: Codable, CustomStringConvertible {
        
        
        // These are the normal plist things

        public let CFBundleDevelopmentRegion: String
        public let CFBundleExecutable: String
        public let CFBundleIdentifier: String
        public let CFBundleInfoDictionaryVersion: String
        public let CFBundleName: String
        public let CFBundlePackageType: String
        public let CFBundleShortVersionString: String
        public let CFBundleVersion: String
        
        // Custom plist properties are added here
    \(plistVar)
        
        public var description: String {
            return \"""
            Configuration.swift read from Info.plist of ReactNativeConfigSwift framework
    
            // Config variable of Framework ReactNativeConfigSwift
    
                * CFBundleDevelopmentRegion = \\(CFBundleDevelopmentRegion)
                * CFBundleExecutable = \\(CFBundleExecutable)
                * CFBundleIdentifier = \\(CFBundleIdentifier)
                * CFBundleInfoDictionaryVersion = \\(CFBundleInfoDictionaryVersion)
                * CFBundleName = \\(CFBundleName)
                * CFBundlePackageType = \\(CFBundlePackageType)
                * CFBundleShortVersionString = \\(CFBundleShortVersionString)
                * CFBundleVersion = \\(CFBundleVersion)
    
            // Custom environment dependend constants from .env.debug.json or .env.release.json 

    \(plistVarString)
            \"""
        }
    
    }
    
    """
    try configurationFiles.configurationFile.write(string: plistLinesSwift)
    
    let plistLinesXmlText: String = text
        .map { $0.xmlEntry }
        .map {"      \($0)"}
        .joined(separator: "\n")
    
    let plistLinesXml = """
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
        \(plistLinesXmlText)
    </dict>
    </plist>
    """
    
    try configurationFiles.plistFile.write(string: plistLinesXml)
    SignPost.shared.message("🚀 ReactNativeConfig main.swift ✅")
    
    exit(EXIT_SUCCESS)
} catch {
    SignPost.shared.error("""
    ❌ Prepare React Native Config
    
         \(error)
    
    ❌
        ♥️ Fix it by adding \(ConfigurationFiles.debugJSON) & \(ConfigurationFiles.releaseJSON) or (optionally) \(ConfigurationFiles.localJSON)at <#react native#>/
    """
    )
    exit(EXIT_FAILURE)
}

