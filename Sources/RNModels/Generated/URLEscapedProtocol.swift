import Foundation
import SourceryAutoProtocols

// DO NOT EDIT

// sourcery:AutoMockable
public protocol URLEscapedProtocol
{
    var url: URL { get }

    func encode(to encoder: Encoder) throws
}

extension URLEscapedProtocol
{}
