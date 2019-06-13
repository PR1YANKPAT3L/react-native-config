//
//  PlistWriter.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 06/06/2019.
//

import Foundation
import SourceryAutoProtocols
import ZFile

public struct PlistWriter: PlistWriterProtocol, AutoGenerateProtocol
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

    public init() {}

    public func writeRNConfigurationPlist(output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        try writeRNConfigurationPlist(to: output.ios.infoPlistRNConfiguration, sampler: sampler)
        try writeRNConfigurationPlist(to: output.ios.infoPlistRNConfigurationTests, sampler: sampler)
    }

    private func writeRNConfigurationPlist(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
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
