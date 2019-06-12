//
//  Protocols.swift
//  BuildConfiguration
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation

// sourcery:AutoMockable
public protocol JSONEnvironmentProtocol
{
    // sourcery:inline:JSONEnvironment.AutoGenerateProtocol
    var typed: [String: TypedJsonEntry]? { get }
    var booleans: [String: Bool]? { get }

    func xcconfigEntry(for configuration: Configuration) throws -> String
    func androidEnvEntry() throws -> String
    // sourcery:end
}

// sourcery:AutoMockable
public protocol JSONEnvironmentsProtocol
{
    // sourcery:inline:JSONEnvironments.AutoGenerateProtocol
    var debug: JSONEnvironment { get }
    var release: JSONEnvironment { get }
    var local: JSONEnvironment { get }
    var betaRelease: JSONEnvironment { get }
    var config: [RNModels.Configuration: JSONEnvironment] { get }
    // sourcery:end
}
