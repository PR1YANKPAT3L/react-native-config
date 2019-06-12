//
//  RNConfigurationBridgeCodeSample.swift
//  CoderLibrary
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation
import RNModels
import SourceryAutoProtocols
import ZFile

public struct JSBridgeCodeSample: JSBridgeCodeSampleProtocol, AutoGenerateProtocol
{
    // MARK: - Code

    // "@@"<#key#>" : @"<#value#>"";

    public let bridgeEnv: [RNModels.Configuration: [String]]

    public func writeRNConfigurationBridge(to file: FileProtocol) throws
    {
        try file.write(
            string: """
            \(JSBridgeCodeSample.top)
            \(code)
            \(JSBridgeCodeSample.bottom)
            """
        )
    }

    public init(bridgeEnv: [RNModels.Configuration: [String]])
    {
        self.bridgeEnv = bridgeEnv
        code = """
        + (NSDictionary *)env {
        #ifdef DEBUG
        #ifdef LOCAL
        return @{
        \(self.bridgeEnv[.Local]?.joined(separator: ",\n") ?? "")
        };
        #else
        return @{
        \(self.bridgeEnv[.Debug]?.joined(separator: ",\n") ?? "")
        };
        #endif
        #elif RELEASE
        return @{
        \(self.bridgeEnv[.Release]?.joined(separator: ",\n") ?? "")
        };
        #elif BETARELEASE
        return @{
        \(self.bridgeEnv[.BetaRelease]?.joined(separator: ",\n") ?? "")
        };
        #else
        NSLog(@"⚠️ (Coder) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
        return nil;
        #endif
        }
        """
    }

    // MARK: - Code Templates

    private static let top = """
    #import "ReactNativeConfig.h"
    #import <Foundation/Foundation.h>

    @implementation ReactNativeConfig

    RCT_EXPORT_MODULE()

    + (BOOL)requiresMainQueueSetup
    {
        return YES;
    }

    """

    private let code: String

    private static let bottom = """
    + (NSString *)envFor: (NSString *)key {
        NSString *value = (NSString *)[self.env objectForKey:key];
        return value;
    }

    - (NSDictionary *)constantsToExport {
        return [ReactNativeConfig env];
    }
    
    @end
    """
}
