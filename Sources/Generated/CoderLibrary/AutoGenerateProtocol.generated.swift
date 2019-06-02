// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//: Do not change this code as it is autogenerated every time you build.
//: You can change the code in `../StencilTemplatesForSourcery/Application/AutoGenerateProtocol
import Foundation

// MARK: - AutoGenerateProtocol

//: From all Types implementing this protocol Sourcery adds:
//: - public/internal variables // private variables are ignored
//: - public/internal methods (skips initializers)
//: - initializers marked with annotation // sourcery:includeInitInProtocol
//: - of the above it does not add it if  // sourcery:skipProtocol
//: ---

// version 5.5
/*

 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler ..
 // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
 var input: JSONToCodeSampler.InputJSON { get }
 var casesForEnum: String { get }
 var configurationModelVar: String { get }
 var configurationModelVarDescription: String { get }
 var plistLinesXmlText: String { get }
 var decoderInit: String { get }
 var bridgeEnv: BridgeEnvProtocol { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler ✅
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler.BridgeEnv ..
 // sourcery:inline:JSONToCodeSampler.BridgeEnv.AutoGenerateProtocol
 var local: [String] { get }
 var debug: [String] { get }
 var release: [String] { get }
 var betaRelease: [String] { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler.BridgeEnv ✅
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler.InputJSON ..
 // sourcery:inline:JSONToCodeSampler.InputJSON.AutoGenerateProtocol
 var debug: JSONProtocol { get }
 var release: JSONProtocol { get }
 var local: JSONProtocol? { get }
 var betaRelease: JSONProtocol? { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler.InputJSON ✅

 // type.annotations.AutoGenerateProtocol for Coder -> See code in the file of that type

 // sourcery:inline:Coder.AutoGenerateProtocol
 var configurationDisk: ConfigurationDiskProtocol { get }
 var codeSampler: JSONToCodeSamplerProtocol { get }
 var signPost: SignPostProtocol { get }
 static var rnConfigurationModelDefault_TOP: String { get }
 static var rnConfigurationModelDefault_BOTTOM: String { get }
 static var factoryTop: String { get }
 static var rnConfigurationModelFactoryProtocolDefault: String { get }
 static var plistLinesXmlDefault: String { get }

 func attempt() throws  -> Coder.Config
 func attemptWriteInfoPlistToAllPlists(in folder: FolderProtocol) throws
 func writeRNConfigurationBridge() throws
 func writeRNConfigurationModel() throws
 func writeRNConfigurationModelFactory() throws
 func writeRNConfigurationPlist() throws
 func writeRNConfigurationPlist(to file: FileProtocol) throws
 // sourcery:end
 // type.annotations.AutoGenerateProtocol for Coder end
 // type.annotations.AutoGenerateProtocol for Coder.RNConfigurationBridge -> See code in the file of that type

 // sourcery:inline:Coder.RNConfigurationBridge.AutoGenerateProtocol
 var envLocal: [String] { get }
 var envDebug: [String] { get }
 var envRelease: [String] { get }
 var envBetaRelease: [String] { get }
 static var top: String { get }
 var env: String { mutating get }
 static var bottom: String { get }

 // sourcery:end
 // type.annotations.AutoGenerateProtocol for Coder.RNConfigurationBridge end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk -> See code in the file of that type

 // sourcery:inline:ConfigurationDisk.AutoGenerateProtocol
 static var projectNameWithPrepareScript: String { get }
 var environmentJsonFilesFolder: FolderProtocol { get }
 var rnConfigurationSourcesFolder: FolderProtocol { get }
 var rnConfigurationBridgeSourcesFolder: FolderProtocol { get }
 var inputJSON: InputProtocol { get }
 var androidFolder: FolderProtocol { get }
 var iosFolder: FolderProtocol { get }
 var iOS: OutputProtocol { get }
 var android: OutputProtocol { get }
 var code: GeneratedCodeProtocol { get }

 // sourcery:end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Input -> See code in the file of that type

 // sourcery:inline:ConfigurationDisk.Input.AutoGenerateProtocol
 var debug: FileProtocol { get }
 var release: FileProtocol { get }
 var local: FileProtocol? { get }
 var betaRelease: FileProtocol? { get }

 // sourcery:end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Input end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Output -> See code in the file of that type

 // sourcery:inline:ConfigurationDisk.Output.AutoGenerateProtocol
 var debug: FileProtocol { get }
 var release: FileProtocol { get }
 var local: FileProtocol? { get }
 var betaRelease: FileProtocol? { get }

 // sourcery:end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Output end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Output.GeneratedCode -> See code in the file of that type

 // sourcery:inline:ConfigurationDisk.Output.GeneratedCode.AutoGenerateProtocol
 var rnConfigurationModelFactorySwiftFile: FileProtocol { get }
 var infoPlistRNConfiguration: FileProtocol { get }
 var infoPlistRNConfigurationTests: FileProtocol { get }
 var rnConfigurationModelSwiftFile: FileProtocol { get }
 var rnConfigurationBridgeObjectiveCMFile: FileProtocol { get }

 func clearContentAllFiles() throws
 // sourcery:end
 // type.annotations.AutoGenerateProtocol for ConfigurationDisk.Output.GeneratedCode end
 */
