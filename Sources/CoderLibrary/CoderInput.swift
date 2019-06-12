//
//  EnvironmentFiles.swift
//  PrepareReactNativeConfig
//
//  Created by Stijn on 15/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Errors
import Foundation
import HighwayLibrary
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// MARK: - Struct

public struct CoderInput: CoderInputProtocol, AutoGenerateProtocol
{
    public static let projectNameWithPrepareScript: String = "Coder.xcodeproj"
    /**
     The name of the json file containing all configurations
     */
    public static var jsonFileName: String = "coder.env.json"

    public let inputJSONFile: FileProtocol

    // MARK: - Init

    public init(inputJSONFile: FileProtocol)
    {
        self.inputJSONFile = inputJSONFile
    }
}
