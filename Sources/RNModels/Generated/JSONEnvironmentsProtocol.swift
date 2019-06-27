import Foundation
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol JSONEnvironmentsProtocol
{
    var debug: JSONEnvironment { get }
    var release: JSONEnvironment { get }
    var local: JSONEnvironment { get }
    var betaRelease: JSONEnvironment { get }
    var config: [RNModels.Configuration: JSONEnvironment] { get }
}

extension JSONEnvironmentsProtocol
{}
