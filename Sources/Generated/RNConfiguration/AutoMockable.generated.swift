import Foundation
import RNConfiguration
import RNModels


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - RNConfigurationModelProtocolMock

open class RNConfigurationModelProtocolMock: RNConfigurationModelProtocol {

    public init() {}

  public  var exampleBool: Bool {
      get { return underlyingExampleBool }
      set(value) { underlyingExampleBool = value }
  }
  public  var underlyingExampleBool: Bool = false
  public  var url: URLEscaped {
      get { return underlyingUrl }
      set(value) { underlyingUrl = value }
  }
  public  var underlyingUrl: URLEscaped!
  public  var description: String {
      get { return underlyingDescription }
      set(value) { underlyingDescription = value }
  }
  public  var underlyingDescription: String = "AutoMockable filled value"


  // MARK: - <create> - parameters

  public static var createFromThrowableError: Error?
  public static var createFromCallsCount = 0
  public static var createFromCalled: Bool {
    return createFromCallsCount > 0
  }
  public static var createFromReceivedJson: JSON?
  public static var createFromReturnValue: RNConfigurationModel?

  // MARK: - <create> - closure mocks

  public static var createFromClosure: ((JSON) throws  -> RNConfigurationModel)? = nil



  // MARK: - <create> - method mocked

  public static  func create(from json: JSON) throws -> RNConfigurationModel {


      // <create> - Throwable method implementation

    if let error = createFromThrowableError {
        throw error
    }

      createFromCallsCount += 1
      createFromReceivedJson = json

      // <create> - Return Value mock implementation

      guard let closureReturn = createFromClosure else {
          guard let returnValue = createFromReturnValue else {
              let message = "No returnValue implemented for createFromClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement RNConfigurationModel

              throw error
          }
          return returnValue
      }

      return try closureReturn(json)
  }
}


// MARK: - OBJECTIVE-C



// MARK: - Sourcery Errors

public enum SourceryMockError: Swift.Error, Hashable
{
    case implementErrorCaseFor(String)
    case subclassMockBeforeUsing(String)

    public var debugDescription: String
    {
        switch self
        {
        case let .implementErrorCaseFor(message):
            return """
            🧙‍♂️ SourceryMockError.implementErrorCaseFor:
            message: \(message)
            """
        case let .subclassMockBeforeUsing(message):
            return """
            \n
            🧙‍♂️ SourceryMockError.subclassMockBeforeUsing:
            message: \(message)
            """
        }
    }
}
