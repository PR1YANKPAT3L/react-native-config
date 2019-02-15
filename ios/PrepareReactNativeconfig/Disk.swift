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

struct Disk {
    
    struct FileName {
        
        struct JSON {
            static let debug = ".env.debug.json"
            static let release = ".env.release.json"
            static var local = ".env.local.json"
        }

    }
    
    let inputJSON: Input
    
    let reactNativeFolder: FolderProtocol
    let reactNativeConfigSwiftSourcesFolder: FolderProtocol
    let androidFolder: FolderProtocol
    let iosFolder: FolderProtocol
    
    let iOS: Output
    let android: Output
    
    let code: Output.Code
    
    struct Input {
        let debug: FileProtocol
        let release: FileProtocol
        let local: FileProtocol?
    }
    
    struct Output {
        let debug: FileProtocol
        let release: FileProtocol
        let local: FileProtocol?
        
        struct Code {
            let configurationWorkerFile: FileProtocol
            let infoPlist: FileProtocol
            let currentBuild: FileProtocol
        }
    }
    
    init(reactNativeFolder: FolderProtocol) throws {
        var reactNativeFolder = reactNativeFolder
        
        var debugJSON: FileProtocol!
        var releaseJSON: FileProtocol!
        var localJSON: FileProtocol?
        
        var androidFolder: FolderProtocol!
        var iosFolder: FolderProtocol!
        
        do {
            SignPost.shared.verbose("PrepareReactNativeconfig run from post install in node_modules folder")
            debugJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.debug)
            releaseJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.release)
            do { localJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.local) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(Disk.FileName.JSON.local) to have a local config. Ignoring for now") }
            iosFolder = try reactNativeFolder.subfolder(named: "/Carthage/Checkouts/react-native-config/ios")
            androidFolder = try reactNativeFolder.subfolder(named: "android")
        } catch {
            
            reactNativeFolder = try reactNativeFolder.parentFolder().parentFolder().parentFolder()
            
            SignPost.shared.verbose("PrepareReactNativeconfig run from building in the carthage checkouts folder")
            debugJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.debug)
            releaseJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.release)
            do { localJSON = try reactNativeFolder.file(named: Disk.FileName.JSON.local) } catch { signPost.message("💁🏻‍♂️ If you would like you can add \(Disk.FileName.JSON.local) to have a local config. Ignoring for now") }
            
            iosFolder = currentFolder
            androidFolder = try reactNativeFolder.subfolder(named: "android")
        }
        
        reactNativeConfigSwiftSourcesFolder = try iosFolder.subfolder(named: "ReactNativeConfigSwift")
        
        self.inputJSON = Input(
            debug: debugJSON,
            release: releaseJSON,
            local: localJSON
        )
        
        self.androidFolder = androidFolder
        self.iosFolder = iosFolder
        self.reactNativeFolder = reactNativeFolder
        
        var localXconfigFile: FileProtocol?
        var localAndroidConfigurationFile: FileProtocol?
        
        if localJSON != nil {
            localXconfigFile = try iosFolder.createFileIfNeeded(named: "Local.xcconfig")
            localAndroidConfigurationFile = try androidFolder.createFileIfNeeded(named: ".env.local")
        } else {
            localXconfigFile = nil
            localAndroidConfigurationFile = nil
        }
        
        iOS = Output(
            debug: try iosFolder.createFileIfNeeded(named: "Debug.xcconfig"),
            release: try iosFolder.createFileIfNeeded(named: "Release.xcconfig"),
            local: localXconfigFile
        )
        
        android = Output(
            debug: try androidFolder.createFileIfNeeded(named: ".env.debug"),
            release: try androidFolder.createFileIfNeeded(named: ".env.release"),
            local: localAndroidConfigurationFile
        )
        
        code = Output.Code(
            configurationWorkerFile: try reactNativeConfigSwiftSourcesFolder.createFileIfNeeded(named: "CurrentBuildConfigurationWorker.swift"),
            infoPlist: try iosFolder.subfolder(named: "ReactNativeConfigSwift").createFileIfNeeded(named: "Info.plist"),
            currentBuild: try reactNativeConfigSwiftSourcesFolder.createFileIfNeeded(named: "CurrentBuildConfiguration.swift")
        )
        
    }
    
}
