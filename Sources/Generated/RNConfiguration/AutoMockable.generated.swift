import Foundation
import RNConfiguration
import RNModels
import SourceryAutoProtocols


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


// MARK: - RNConfigurationModelFactoryProtocolMock

open class RNConfigurationModelFactoryProtocolMock: NSObject, RNConfigurationModelFactoryProtocol {

override public init() { super.init() }



  // MARK: - <allValuesDictionary> - parameters

  public static var allValuesDictionaryThrowableError: Error?
  public static var allValuesDictionaryCallsCount = 0
  public static var allValuesDictionaryCalled: Bool {
    return allValuesDictionaryCallsCount > 0
  }
  public static var allValuesDictionaryReturnValue: [String : String]?

  // MARK: - <allValuesDictionary> - closure mocks

  public static var allValuesDictionaryClosure: (() throws  -> [String : String])? = nil



  // MARK: - <allValuesDictionary> - method mocked

  public static  func allValuesDictionary() throws -> [String : String] {


      // <allValuesDictionary> - Throwable method implementation

    if let error = allValuesDictionaryThrowableError {
        throw error
    }

      allValuesDictionaryCallsCount += 1

      // <allValuesDictionary> - Return Value mock implementation

      guard let closureReturn = allValuesDictionaryClosure else {
          guard let returnValue = allValuesDictionaryReturnValue else {
              let message = "No returnValue implemented for allValuesDictionaryClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String : String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <allCustomKeys> - parameters

  public var allCustomKeysCallsCount = 0
  public var allCustomKeysCalled: Bool {
    return allCustomKeysCallsCount > 0
  }
  public var allCustomKeysReturnValue: [String]
    static func readCurrentBuildConfiguration(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> RNConfigurationModel
    static func allConstants(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> [RNConfigurationModelFactory.Case: String]?

  // MARK: - <allCustomKeys> - closure mocks

  public var allCustomKeysClosure: (()  -> [String]
    static func readCurrentBuildConfiguration(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> RNConfigurationModel
    static func allConstants(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> [RNConfigurationModelFactory.Case: String])? = nil



  // MARK: - <allCustomKeys> - method mocked

  open func allCustomKeys() -> [String]
    static func readCurrentBuildConfiguration(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> RNConfigurationModel
    static func allConstants(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> [RNConfigurationModelFactory.Case: String] {

      allCustomKeysCallsCount += 1

      // <allCustomKeys> - Return Value mock implementation

      guard let closureReturn = allCustomKeysClosure else {
          guard let returnValue = allCustomKeysReturnValue else {
              let message = "No returnValue implemented for allCustomKeysClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]
    static func readCurrentBuildConfiguration(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> RNConfigurationModel
    static func allConstants(infoDict: [String: Any]? = Bundle(for: RNConfigurationModelFactory.self).infoDictionary) throws  -> [RNConfigurationModelFactory.Case: String]

              print("❌ \(error)")

              fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
          }
          return returnValue
      }

      return closureReturn()
  }
}



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
