//
//  JSON.swift
//  RNConfiguration-iOS
//
//  Created by Stijn on 18/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
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
    // sourcery:end
}

// sourcery:AutoGenerateProtocol
public struct JSONEnvironments: Codable, JSONEnvironmentsProtocol
{
    public let debug: JSONEnvironment
    public let release: JSONEnvironment
    public let local: JSONEnvironment
    public let betaRelease: JSONEnvironment
}

// MARK: - JSON struct

// sourcery:AutoGenerateProtocol
public struct JSONEnvironment: Codable, JSONEnvironmentProtocol
{
    public let typed: [String: TypedJsonEntry]?
    public let booleans: [String: Bool]?

    public func xcconfigEntry(for configuration: Configuration) throws -> String
    {
        var entries = [String]()
        let configSelector = "[config=\(configuration)]"
        if let typed = typed
        {
            entries = try typed
                .map { return "\($0.key) \(configSelector) = \(try xcconfigRawValue(for: $0.value))" }
                .sorted()
        }

        if let booleanEntries = booleans
        {
            entries.append(
                contentsOf: booleanEntries
                    .map { "\($0.key) \(configSelector) = \($0.value)" }
                    .sorted()
            )
        }

        return entries.joined(separator: "\n")
    }

    public func androidEnvEntry() throws -> String
    {
        var entries = [String]()

        if let typed = typed
        {
            entries = try typed
                .map { return "\($0.key) = \(try androidEnvRawValue(for: $0.value))" }
                .sorted()
        }

        if let booleanEntries = booleans
        {
            entries.append(
                contentsOf:
                try booleanEntries
                    .map
                {
                    let key = $0.key
                    let jsonEntry = TypedJsonEntry(typedValue: .bool($0.value))

                    return "\(key) = \(try androidEnvRawValue(for: jsonEntry))"
                }
                .sorted()
            )
        }

        return entries.joined(separator: "\n")
    }

    // MARK: - Private

    private func xcconfigRawValue(for jsonEntry: TypedJsonEntry) throws -> String
    {
        switch jsonEntry.typedValue
        {
        case let .url(url):
            return url.absoluteString
                .replacingOccurrences(of: "http://", with: "http:\\/\\/")
                .replacingOccurrences(of: "https://", with: "https:\\/\\/")
        case let .string(string):
            return string
        case let .int(int):
            return "\(int)"
        case let .bool(boolValue):
            return "\(boolValue)"
        }
    }

    private func androidEnvRawValue(for jsonEntry: TypedJsonEntry) throws -> String
    {
        switch jsonEntry.typedValue
        {
        case let .url(url):
            return url.absoluteString
        case let .string(string):
            return string
        case let .int(int):
            return "\(int)"
        case let .bool(boolValue):
            return "\(boolValue)"
        }
    }
}
