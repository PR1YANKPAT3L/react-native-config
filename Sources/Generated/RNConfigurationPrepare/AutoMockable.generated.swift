import Foundation
import RNConfigurationPrepare
import SignPost
import SourceryAutoProtocols


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


















// MARK: - TestRunnerProtocolMock

open class TestRunnerProtocolMock: TestRunnerProtocol {

    public init() {}



  // MARK: - <attempt> - parameters

  public var attemptThrowableError: Error?
  public var attemptCallsCount = 0
  public var attemptCalled: Bool {
    return attemptCallsCount > 0
  }

  // MARK: - <attempt> - closure mocks

  public var attemptClosure: (() throws  -> Void)? = nil



  // MARK: - <attempt> - method mocked

  open func attempt() throws {


      // <attempt> - Throwable method implementation

    if let error = attemptThrowableError {
        throw error
    }

      attemptCallsCount += 1

      // <attempt> - Void return mock implementation

        try attemptClosure?()

  }
}


// MARK: - OBJECTIVE-C

