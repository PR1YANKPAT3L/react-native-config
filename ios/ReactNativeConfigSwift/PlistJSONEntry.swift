//
//  PlistEntry.swift
//  ReactNativeConfigSwift
//
//  Created by Stijn on 30/01/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

public struct JSONEntry: Codable {
    public let value: String
    public let valueType: String
    
    public let typedValue: PossibleTypes
    
    init(
        typedValue: PossibleTypes
        ) {
        self.value = "\(typedValue)"
        self.valueType = typedValue.typeSwiftString
        self.typedValue = typedValue
    }
    
    public enum PossibleTypes {
        
        public typealias RawValue = String
        
        case url(URL)
        case string(String)
        case int(Int)
        case bool(Bool)
    
        var typeSwiftString: String {
            switch self {
            case .url(_):
                return "URLEscaped"
            case .int(_):
                return "Int"
            case .string(_):
                return "String"
            case .bool(_):
                return "Bool"
            }
        }
        
        var typePlistString: String {
            return typeSwiftString.lowercased()
        }
        
        var valueString: String {
            switch self {
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
    
    public enum CodingKeys: String, CodingKey {
        case value
        case valueType
    }
    
    public enum Error: Swift.Error {
        case couldNotResolveType(String)
        case invalidUrl(String)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
        valueType = try container.decode(String.self, forKey: .valueType)
        
        switch valueType.lowercased() {
        case "url":
            guard let url = URL(string: value) else {
                throw Error.invalidUrl(value)
            }
            
            typedValue = .url(url)
        case "string":
            typedValue = .string(value)
        case "int":
            guard let int = Int(value) else {
                throw Error.invalidUrl(value)
            }
            
            typedValue = .int(int)
        case "bool":
            guard let _value = Bool(value) else {
                throw Error.invalidUrl(value)
            }
            
            typedValue = .bool(_value)
        default:
            throw Error.couldNotResolveType(valueType)
        }
        
    }
}
