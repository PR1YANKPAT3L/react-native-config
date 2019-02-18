//
//  JSON.swift
//  ReactNativeConfigSwift-iOS
//
//  Created by Stijn on 18/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

// MARK: - JSON struct

public struct JSON: Codable {
    
    public let typed: [String: JSONEntry]
    public let booleans: [String: Bool]
    
    public func xcconfigEntry() throws -> String {
        var entries = try typed
            .map { return "\($0.key) = \(try xcconfigRawValue(for: $0.value))"}
            .sorted()
        
        let booleanEntries = booleans
            .map { return "\($0.key) = \($0.value)"}
            .sorted()
        entries.append(contentsOf: booleanEntries)
        
        return entries.joined(separator: "\n")
    }
    
    public func androidEnvEntry() throws -> String {
        var entries = try typed
            .map { return "\($0.key) = \(try androidEnvRawValue(for: $0.value))" }
            .sorted()
        
        let booleanEntries: [String] = try booleans
            .map {
                let key = $0.key
                let jsonEntry = JSONEntry(typedValue: .bool($0.value))
                return "\(key) = \(try androidEnvRawValue(for: jsonEntry))"}
            .sorted()
        
        entries.append(contentsOf: booleanEntries)
        
        return entries.joined(separator: "\n")
    }
    
    // MARK: - Private
    
    private func xcconfigRawValue(for jsonEntry: JSONEntry) throws -> String {
        switch jsonEntry.typedValue {
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
    
    private func androidEnvRawValue(for jsonEntry: JSONEntry) throws -> String {
        switch jsonEntry.typedValue {
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
