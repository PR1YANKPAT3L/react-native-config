//
//  EnvironmentFiles.swift
//  PrepareReactNativeconfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import SignPost
import ZFile

struct ConfigurationFiles {
    
    static let debugJSON = ".env.debug.json"
    static let releaseJSON = ".env.release.json"
    static var localJSON = ".env.local.json"

    let reactNativeFolder: FolderProtocol
    let reactNativeConfigSwiftSourcesFolder: FolderProtocol
    
    let debugJSONfile: FileProtocol
    let releaseJSONfile: FileProtocol
    let localJSONfile: FileProtocol?
    
    let androidFolder: FolderProtocol
    let iosFolder: FolderProtocol
    
    let configurationWorkerFile: FileProtocol
    let plistFile: FileProtocol
    let configurationFile: FileProtocol
    
    let debugXconfigFile: FileProtocol
    let releaseXconfigFile: FileProtocol
    let localXconfigFile: FileProtocol?
    
    init(reactNativeFolder: FolderProtocol) throws {
        var reactNativeFolder = reactNativeFolder
        
        var debugJSON: FileProtocol!
        var releaseJSON: FileProtocol!
        var localJSON: FileProtocol?
        
        var androidFolder: FolderProtocol!
        var iosFolder: FolderProtocol!
        
        do {
            SignPost.shared.verbose("PrepareReactNativeconfig run from post install in node_modules folder")
            debugJSON = try reactNativeFolder.file(named: ConfigurationFiles.debugJSON)
            releaseJSON = try reactNativeFolder.file(named: ConfigurationFiles.releaseJSON)
            do { localJSON = try reactNativeFolder.file(named: ConfigurationFiles.localJSON) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationFiles.localJSON) to have a local config. Ignoring for now") }
            iosFolder = try reactNativeFolder.subfolder(named: "/Carthage/Checkouts/react-native-config/ios")
            androidFolder = try reactNativeFolder.subfolder(named: "android")
        } catch {
            
            reactNativeFolder = try reactNativeFolder.parentFolder().parentFolder().parentFolder()
            
            SignPost.shared.verbose("PrepareReactNativeconfig run from building in the carthage checkouts folder")
            debugJSON = try reactNativeFolder.file(named: ConfigurationFiles.debugJSON)
            releaseJSON = try reactNativeFolder.file(named: ConfigurationFiles.releaseJSON)
            do { localJSON = try reactNativeFolder.file(named: ConfigurationFiles.localJSON) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(ConfigurationFiles.localJSON) to have a local config. Ignoring for now") }
            
            iosFolder = currentFolder
            androidFolder = try reactNativeFolder.subfolder(named: "android")
        }
        
        reactNativeConfigSwiftSourcesFolder = try iosFolder.subfolder(named: "ReactNativeConfigSwift")
        
        self.debugJSONfile = debugJSON
        self.releaseJSONfile = releaseJSON
        self.localJSONfile = localJSON
        self.androidFolder = androidFolder
        self.iosFolder = iosFolder
        self.reactNativeFolder = reactNativeFolder
        
        configurationWorkerFile = try reactNativeConfigSwiftSourcesFolder.createFileIfNeeded(named: "ConfigurationWorker.swift")
        plistFile = try iosFolder.subfolder(named: "ReactNativeConfigSwift").createFileIfNeeded(named: "Info.plist")
        configurationFile = try reactNativeConfigSwiftSourcesFolder.createFileIfNeeded(named: "Configuration.swift")
        
        debugXconfigFile = try iosFolder.createFileIfNeeded(named: "Debug.xcconfig")
        releaseXconfigFile = try iosFolder.createFileIfNeeded(named: "Release.xcconfig")

        if localJSON != nil {
            localXconfigFile = try iosFolder.createFileIfNeeded(named: "Local.xcconfig")
        } else {
            localXconfigFile = nil
        }
    }
    
}
