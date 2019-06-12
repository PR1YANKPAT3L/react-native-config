//
//  JSONEnvironments.swift
//  RNModels
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation

// sourcery:AutoGenerateProtocol
public struct JSONEnvironments: Codable, JSONEnvironmentsProtocol
{
    public let debug: JSONEnvironment
    public let release: JSONEnvironment
    public let local: JSONEnvironment
    public let betaRelease: JSONEnvironment

    public var config: [RNModels.Configuration: JSONEnvironment]
    {
        return [
            .Debug: debug,
            .Release: release,
            .Local: local,
            .BetaRelease: betaRelease,
        ]
    }
}
