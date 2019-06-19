//
//  CoderOutputProtocol.swift
//  Coder
//
//  Created by Stijn Willems on 11/06/2019.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol CoderOutputProtocol: AutoMockable
{
    var android: CoderOutputAndroidProtocol { get }
    var ios: CoderOutputiOSProtocol { get }
}

public protocol CoderOutputAndroidProtocol: AutoMockable
{
    var sourcesFolder: FolderProtocol { get }
    var configFiles: [RNModels.Configuration: FileProtocol] { get }
}

public protocol CoderOutputiOSProtocol: AutoMockable
{
    var sourcesFolder: FolderProtocol { get }
    var xcconfigFile: FileProtocol { get }
    var factory: FileProtocol { get }
    var model: FileProtocol { get }
    var plists: [FileProtocol] { get }
    var jsBridgeHeader: FileProtocol { get }
    var jsBridgeImplementation: FileProtocol { get }
    // sourcery:end
}
