//
//  TextfileWriter.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 02/06/2019.
//

import Errors
import Foundation
import RNModels
import SourceryAutoProtocols
import ZFile

public protocol TextFileWriterProtocol: AutoMockable
{
    // sourcery:inline:TextFileWriter.AutoGenerateProtocol
    static var shared: TextFileWriterProtocol { get }
    var decoder: JSONDecoder { get }

    func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws -> JSONProtocol?
    func writeIOSAndAndroidConfigFiles(from disk: ConfigurationDiskProtocol) throws -> EnvJSONsProtocol
    func setupCodeSamples(json: JSONProtocol) -> TextFileWriter.Sample
    // sourcery:end
}

public struct TextFileWriter: TextFileWriterProtocol, AutoGenerateProtocol
{
    public static let shared: TextFileWriterProtocol = TextFileWriter()
    public typealias Sample = [(case: String, configurationModelVar: String, configurationModelVarDescription: String, xmlEntry: String, decoderInit: String)]

    public let decoder: JSONDecoder

    // MARK: - Init

    public init(
        decoder: JSONDecoder = JSONDecoder()
    )
    {
        self.decoder = decoder
    }

    // MARK: - Writing to text files for android and ios

    /**
     Writes configuration entries to files. For android these are several files. For iOS it is a single file
     */
    public func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws -> JSONProtocol?
    {
        guard let jsonFile = jsonFile else { return nil }

        let json = try decoder.decode(JSON.self, from: try jsonFile.read())

        try android?.write(string: try json.androidEnvEntry())
        let entry = try json.xcconfigEntry(for: configuration)

        guard let content = try ios?.readAsString(), !content.contains(entry) else
        {
            return json
        }

        try ios?.append(string: "\n")

        try ios?.append(string: entry)

        return json
    }

    public func writeIOSAndAndroidConfigFiles(from disk: ConfigurationDiskProtocol) throws -> EnvJSONsProtocol
    {
        let _debug = try writeConfigIfNeeded(from: disk.inputJSON.debug, for: .Debug, android: disk.android.debug, ios: disk.xcconfigFile)
        let _release = try writeConfigIfNeeded(from: disk.inputJSON.release, for: .Release, android: disk.android.release, ios: disk.xcconfigFile)

        guard let debug = _debug, let release = _release else { throw "\(pretty_function()) debug or release config missing!" }

        return EnvJSONs(
            debug: debug,
            release: release,
            local: try writeConfigIfNeeded(from: disk.inputJSON.local, for: .Local, android: disk.android.local, ios: disk.xcconfigFile),
            betaRelease: try writeConfigIfNeeded(from: disk.inputJSON.betaRelease, for: .BetaRelease, android: disk.android.betaRelease, ios: disk.xcconfigFile)
        )
    }

    public func setupCodeSamples(json: JSONProtocol) -> TextFileWriter.Sample
    {
        var allKeys: Sample = json.typed?.enumerated().compactMap
        {
            let key = $0.element.key
            let typedValue = $0.element.value.typedValue
            let swiftTypeString = typedValue.typeSwiftString
            let xmlType = typedValue.typePlistString

            return (
                case: "case \(key)",
                configurationModelVar: "public let \(key): \(swiftTypeString)",
                configurationModelVarDescription: "\(key): \\(\(key))",
                xmlEntry: """
                <key>\(key)</key>
                <\(xmlType)>$(\(key))</\(xmlType)>
                """,
                decoderInit: "\(key) = try container.decode(\(swiftTypeString).self, forKey: .\(key))"
            )
        } ?? [(case: String, configurationModelVar: String, configurationModelVarDescription: String, xmlEntry: String, decoderInit: String)]()

        if let booleanKeys: Sample = (
            json.booleans?.enumerated().compactMap
            {
                let key = $0.element.key
                let typedValue = JSONEntry.PossibleTypes.bool($0.element.value)
                let swiftTypeString = typedValue.typeSwiftString

                return (
                    case: "case \(key)",
                    configurationModelVar: "public let \(key): \(swiftTypeString)",
                    configurationModelVarDescription: "\(key): \\(\(key))",
                    xmlEntry: """
                    <key>\(key)</key>
                    <string>$(\(key))</string>
                    """,
                    decoderInit: """
                    
                    guard let \(key) = Bool(try container.decode(String.self, forKey: .\(key))) else { throw Error.invalidBool(forKey: \"\(key)\")}
                    
                    self.\(key) = \(key)
                    """
                )
            }
        )
        {
            allKeys.append(contentsOf: booleanKeys)
        }

        return allKeys
    }
}
