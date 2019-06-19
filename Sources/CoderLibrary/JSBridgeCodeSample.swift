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
    public init() {}

    public func writeBridge(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
    {
        let bridgeEnv = sampler.bridgeEnv

        let code = """
        + (NSDictionary *)env {
        #ifdef DEBUG
        #ifdef LOCAL
            return @{
                \(bridgeEnv[.Local]?.joined(separator: ",\n") ?? "")
            };
        #else
            return @{
                \(bridgeEnv[.Debug]?.joined(separator: ",\n") ?? "")
            };
        #endif
        #elif RELEASE
            return @{
                \(bridgeEnv[.Release]?.joined(separator: ",\n") ?? "")
            };
        #elif BETARELEASE
            return @{
                \(bridgeEnv[.BetaRelease]?.joined(separator: ",\n") ?? "")
            };
        #else
            NSLog(@"⚠️ (Coder) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
            return nil;
        #endif
        }
        """

        try file.write(
            string: """
            \(JSBridgeCodeSample.top)
            \(code)
            \(JSBridgeCodeSample.bottom)
            """
        )
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
