//
//  PlistWriter.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 06/06/2019.
//

import Foundation
import SourceryAutoProtocols
import ZFile

public protocol PlistWriterProtocol: AutoMockable
{
    // sourcery:inline:PlistWriter.AutoGenerateProtocol
    static var plistLinesXmlDefault: String { get }
    var code: GeneratedCodeProtocol { get }
    var sampler: JSONToCodeSamplerProtocol { get }

    func writeRNConfigurationPlist() throws
    func writeRNConfigurationPlist(to file: FileProtocol) throws
    // sourcery:end
}

struct PlistWriter: PlistWriterProtocol, AutoGenerateProtocol
{
    public static let plistLinesXmlDefault = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
        <dict>
        <key>CFBundleDevelopmentRegion</key>
            <string>$(DEVELOPMENT_LANGUAGE)</string>
        <key>CFBundleExecutable</key>
            <string>$(EXECUTABLE_NAME)</string>
        <key>CFBundleIdentifier</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        <key>CFBundleInfoDictionaryVersion</key>
            <string>6.0</string>
        <key>CFBundleName</key>
            <string>$(PRODUCT_NAME)</string>
        <key>CFBundlePackageType</key>
            <string>FMWK</string>
        <key>CFBundleShortVersionString</key>
            <string>1.0</string>
        <key>CFBundleVersion</key>
            <string>$(CURRENT_PROJECT_VERSION)</string>
        </dict>
    </plist>
    """

    public let code: GeneratedCodeProtocol
    public let sampler: JSONToCodeSamplerProtocol

    public init(
        code: GeneratedCodeProtocol,
        sampler: JSONToCodeSamplerProtocol
    )
    {
        self.code = code
        self.sampler = sampler
    }

    public func writeRNConfigurationPlist() throws
    {
        try writeRNConfigurationPlist(to: code.infoPlistRNConfiguration)
        try writeRNConfigurationPlist(to: code.infoPlistRNConfigurationTests)
    }

    public func writeRNConfigurationPlist(to file: FileProtocol) throws
    {
        var plistLinesXml = PlistWriter.plistLinesXmlDefault

        guard sampler.plistLinesXmlText.count > 0 else
        {
            try file.write(string: plistLinesXml)
            return
        }

        plistLinesXml = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>CFBundleDevelopmentRegion</key>
        <string>$(DEVELOPMENT_LANGUAGE)</string>
        <key>CFBundleExecutable</key>
        <string>$(EXECUTABLE_NAME)</string>
        <key>CFBundleIdentifier</key>
        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
        <string>$(PRODUCT_NAME)</string>
        <key>CFBundlePackageType</key>
        <string>FMWK</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0</string>
        <key>CFBundleVersion</key>
        <string>$(CURRENT_PROJECT_VERSION)</string>
        \(sampler.plistLinesXmlText)
        </dict>
        </plist>
        """

        try file.write(string: plistLinesXml)
    }
}
