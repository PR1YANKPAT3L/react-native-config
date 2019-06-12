//
//  Copy.swift
//  Coder
//
//  Created by Stijn Willems on 12/06/2019.
//

import Foundation
import CoderLibrary
import SourceryAutoProtocols
import ZFile

public struct Copy: CopyProtocol, AutoGenerateProtocol
{
    private let output: CoderOutputProtocol
    
    public init(output: CoderOutputProtocol) {
        self.output = output
    }
    
    public func copy(to yourSrcRoot: FolderProtocol) throws
    {
        
    }
}
