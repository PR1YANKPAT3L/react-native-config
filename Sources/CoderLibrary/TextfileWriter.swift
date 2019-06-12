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
    public func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws
    {
        guard let jsonFile = jsonFile else { return }

        let json = try decoder.decode(JSONEnvironment.self, from: try jsonFile.read())

        try android?.write(string: try json.androidEnvEntry())
        let entry = try json.xcconfigEntry(for: configuration)

        guard let content = try ios?.readAsString(), !content.contains(entry) else
        {
            return
        }

        try ios?.append(string: "\n")

        try ios?.append(string: entry)
    }

    public func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws
    {
        try writeConfigIfNeeded(from: input.inputJSONFile, for: .Debug, android: output.android.debug, ios: output.ios.xcconfigFile)
        try writeConfigIfNeeded(from: input.inputJSONFile, for: .Release, android: output.android.release, ios: output.ios.xcconfigFile)
        try writeConfigIfNeeded(from: input.inputJSONFile, for: .Local, android: output.android.local, ios: output.ios.xcconfigFile)
        try writeConfigIfNeeded(from: input.inputJSONFile, for: .Local, android: output.android.local, ios: output.ios.xcconfigFile)
    }

    public func setupCodeSamples(json: JSONEnvironmentProtocol) -> TextFileWriter.Sample
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
                let typedValue = TypedJsonEntry.PossibleTypes.bool($0.element.value)
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
