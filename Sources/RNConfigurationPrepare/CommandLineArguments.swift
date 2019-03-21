//
//  CommandLineArguments.swift
//  RNConfigurationHighwaySetup
//
//  Created by Stijn Willems on 18/03/2019.
//

import Foundation
import ZFile
import SignPost
import Errors

public enum CommandLineArguments: RawRepresentable {
    
    case environmentJsonFilesFolder(FolderProtocol)
    
    public init?(rawValue: String = CommandLine.arguments.joined(separator: ",")) {
        
        let arguments = rawValue.components(separatedBy: ",")
        
        guard let option = (arguments.enumerated().first { $0.element.hasPrefix("environmentJsonFilesFolder") } ),
              arguments.count > option.offset else {
            return nil
        }
        
        do {
            let path = arguments[option.offset - 1]
            self = .environmentJsonFilesFolder(try Folder(path: path))
            return
        } catch {
            SignPost.shared.error("\(HighwayError.highwayError(atLocation: pretty_function(), error: error) )")
            return nil
        }
        
    }
    
    public var rawValue: String {
        return "\(self)"
    }
    
    public var environmentJsonFilesFolder: FolderProtocol? {
        switch self {
        case .environmentJsonFilesFolder(let folder):
            return folder
        default:
            return nil
        }
    }
    
}
