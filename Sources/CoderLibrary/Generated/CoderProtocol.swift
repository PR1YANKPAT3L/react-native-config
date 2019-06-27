import Foundation
import HighwayLibrary
import RNModels
import SignPost
import Terminal
import ZFile

// DO NOT EDIT

// sourcery:AutoMockable
public protocol CoderProtocol
{
    static var modelDefault_TOP: String { get }
    static var modelDefault_BOTTOM: String { get }
    static var factoryTop: String { get }
    static var factoryDefault: String { get }

    func attemptCode(to output: CoderOutputProtocol) throws -> CoderOutputProtocol

    func writeModel(to output: CoderOutputProtocol) throws

    func writeFactory(to output: CoderOutputProtocol) throws
}

extension CoderProtocol
{}
