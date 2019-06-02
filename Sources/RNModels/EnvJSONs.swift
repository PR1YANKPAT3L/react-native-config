//
//  InputJSON.swift
//  RNModels
//
//  Created by Stijn Willems on 02/06/2019.
//

import Foundation
import SourceryAutoProtocols

public protocol EnvJSONsProtocol: AutoMockable
{
    // sourcery:inline:EnvJSONs.AutoGenerateProtocol
    var debug: JSONProtocol { get }
    var release: JSONProtocol { get }
    var local: JSONProtocol? { get }
    var betaRelease: JSONProtocol? { get }
    // sourcery:end
}

public struct EnvJSONs: EnvJSONsProtocol, AutoGenerateProtocol
{
    public let debug: JSONProtocol
    public let release: JSONProtocol
    public let local: JSONProtocol?
    public let betaRelease: JSONProtocol?

    public init(
        debug: JSONProtocol,
        release: JSONProtocol,
        local: JSONProtocol?,
        betaRelease: JSONProtocol?
    )
    {
        self.debug = debug
        self.release = release
        self.local = local
        self.betaRelease = betaRelease
    }
}
