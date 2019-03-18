//
//  TestRunner.swift
//  ReactNativeConfig
//
//  Created by Stijn on 26/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation
import Terminal
import ZFile
import XCBuild
import SourceryAutoProtocols
import Arguments
import SignPost

public protocol TestRunnerProtocol: AutoMockable {
    // sourcery:inline:TestRunner.AutoGenerateProtocol

    func attempt() throws 
    // sourcery:end
}

public struct TestRunner: TestRunnerProtocol, AutoGenerateProtocol {
    
    private let xcbuild: XCBuildProtocol
    private let testOptions: MinimalTestOptionsProtocol
    private let signPost: SignPostProtocol
    
    public init(xcbuild: XCBuildProtocol, testOptions: MinimalTestOptionsProtocol, signPost: SignPostProtocol = SignPost.shared) throws {
       
        self.xcbuild = xcbuild
        self.testOptions = testOptions
        self.signPost = signPost
    }
    
    public func attempt() throws {
        do {
            let result = try xcbuild.buildAndTest(using: testOptions)
            signPost.verbose("\(result)")
        } catch {
            throw "\(TestRunner.self) \(#function) \n\(error)\n"
        }
      
    }
    
}

