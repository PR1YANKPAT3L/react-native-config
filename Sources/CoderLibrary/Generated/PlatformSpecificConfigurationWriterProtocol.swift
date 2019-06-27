import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// DO NOT EDIT

// sourcery:AutoMockable
public protocol PlatformSpecificConfigurationWriterProtocol
{
    static var shared: PlatformSpecificConfigurationWriterProtocol { get }
    var decoder: JSONDecoder { get }

    func writeToAllPlatforms(
        from json: JSONEnvironmentsProtocol,
        output: CoderOutputProtocol
    ) throws
}

extension PlatformSpecificConfigurationWriterProtocol
{}
