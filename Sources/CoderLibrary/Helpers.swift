//
//  Helpers.swift
//  PrepareForConfigurationLibrary
//
//  Created by Stijn Willems on 02/06/2019.
//

import Foundation

// MARK: - Bool

extension Bool
{
    func toObjectiveC() -> String
    {
        switch self
        {
        case true:
            return "@YES"
        case false:
            return "@NO"
        }
    }
}
