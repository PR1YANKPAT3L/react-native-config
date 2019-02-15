//
//  Configuration.swift
//  ReactNativeConfigSwift
//
//  Created by Stijn on 30/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

//⚠️ File is generated and ignored in git. To change it change /PrepareReactNativeconfig/main.swift

public struct CurrentBuildConfiguration: Codable, CustomStringConvertible {


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
    public let ONESIGNAL_APP_ID: String
    public let BOLIDES_ITSME_SECURE_KEY: String
    public let BE_BOLIDES_RELEASE_CHANNEL: String
    public let BOLIDES_BASE_URL: URLEscaped

    public var description: String {
        return """
            Configuration.swift read from Info.plist of ReactNativeConfigSwift framework

            // Config variable of Framework ReactNativeConfigSwift

            * CFBundleDevelopmentRegion = \(CFBundleDevelopmentRegion)
            * CFBundleExecutable = \(CFBundleExecutable)
            * CFBundleIdentifier = \(CFBundleIdentifier)
            * CFBundleInfoDictionaryVersion = \(CFBundleInfoDictionaryVersion)
            * CFBundleName = \(CFBundleName)
            * CFBundlePackageType = \(CFBundlePackageType)
            * CFBundleShortVersionString = \(CFBundleShortVersionString)
            * CFBundleVersion = \(CFBundleVersion)

            // Custom environment dependend constants from .env.debug.json or .env.release.json

            * ONESIGNAL_APP_ID: \(ONESIGNAL_APP_ID)
            * BOLIDES_ITSME_SECURE_KEY: \(BOLIDES_ITSME_SECURE_KEY)
            * BE_BOLIDES_RELEASE_CHANNEL: \(BE_BOLIDES_RELEASE_CHANNEL)
            * BOLIDES_BASE_URL: \(BOLIDES_BASE_URL)
            """
    }

}
