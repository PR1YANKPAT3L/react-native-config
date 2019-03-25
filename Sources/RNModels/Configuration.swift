//
//  Configuration.swift
//  ReactNativeConfig
//
//  Created by Stijn on 20/02/2019.
//  Copyright © 2019 Pedro Belo. All rights reserved.
//

import Foundation

public enum Configuration: String, CaseIterable {
    case Local
    case Debug
    case Release
    case BetaRelease
    
    public func fileName() -> String{
        return self.rawValue.lowerCaseFirstLetter()
    }
}

extension String {
    func lowerCaseFirstLetter() -> String {
         return prefix(1).lowercased() + self.dropFirst()
    }
    
}
