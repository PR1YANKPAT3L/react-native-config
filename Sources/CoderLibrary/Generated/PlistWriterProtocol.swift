import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// DO NOT EDIT

// sourcery:AutoMockable
public protocol PlistWriterProtocol
{
    static var plistLinesXmlDefault: String { get }

    func write(
        output: CoderOutputProtocol,
        sampler: JSONToCodeSamplerProtocol
    ) throws
}

extension PlistWriterProtocol
{}
