//
//  PlistEntry.swift
//  RNConfiguration
//
//  Created by Stijn on 30/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

public struct TypedJsonEntry: Codable
{
    public let value: String
    public let valueType: String

    public let typedValue: PossibleTypes

    // MARK: - Enums

    public enum PossibleTypes
    {
        public typealias RawValue = String

        case url(URL)
        case string(String)
        case int(Int)
        case bool(Bool)

        public var typeSwiftString: String
        {
            switch self
            {
            case .url:
                return "URLEscaped"
            case .int:
                return "Int"
            case .string:
                return "String"
            case .bool:
                return "Bool"
            }
        }

        public var typePlistString: String
        {
            switch self
            {
            case .url(_), .bool:
                return "string"
            default:
                return typeSwiftString.lowercased()
            }
        }

        public var valueString: String
        {
            switch self
            {
            case let .url(url):
                return "\(url.absoluteString)"
            case let .int(int):
                return "\(int)"
            case let .string(string):
                return string
            case let .bool(bool):
                return "\(bool)"
            }
        }
    }

    public enum CodingKeys: String, CodingKey
    {
        case value
        case valueType
    }

    public enum Error: Swift.Error
    {
        case couldNotResolveType(String)
        case invalidUrl(String)
    }

    // MARK: - Initializers

    public init(
        typedValue: PossibleTypes
    )
    {
        value = "\(typedValue)"
        valueType = typedValue.typeSwiftString
        self.typedValue = typedValue
    }

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
        valueType = try container.decode(String.self, forKey: .valueType)

        switch valueType.lowercased()
        {
        case "url":
            guard let url = URL(string: value) else
            {
                throw Error.invalidUrl(value)
            }

            typedValue = .url(url)
        case "string":
            typedValue = .string(value)
        case "int":
            guard let int = Int(value) else
            {
                throw Error.invalidUrl(value)
            }

            typedValue = .int(int)
        case "bool":
            guard let _value = Bool(value) else
            {
                throw Error.invalidUrl(value)
            }

            typedValue = .bool(_value)
        default:
            throw Error.couldNotResolveType(valueType)
        }
    }
}
