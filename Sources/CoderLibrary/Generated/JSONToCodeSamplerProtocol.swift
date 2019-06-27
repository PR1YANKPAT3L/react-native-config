import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// DO NOT EDIT

// sourcery:AutoMockable
public protocol JSONToCodeSamplerProtocol
{
    var jsonEnvironments: JSONEnvironmentsProtocol { get }
    var casesForEnum: String { get }
    var configurationModelVar: String { get }
    var configurationModelVarDescription: String { get }
    var plistLinesXmlText: String { get }
    var decoderInit: String { get }
    var bridgeEnv: [RNModels.Configuration: [String]] { get }
}

extension JSONToCodeSamplerProtocol
{}
