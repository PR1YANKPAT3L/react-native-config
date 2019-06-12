// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
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

 // types.implementing.AutoGenerateProtocol inline for CoderInput ..
 // sourcery:inline:CoderInput.AutoGenerateProtocol
 static var projectNameWithPrepareScript: String { get }
 static var jsonFileName: String { get set }
 var inputJSONFile: FileProtocol { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderInput ✅
 // types.implementing.AutoGenerateProtocol inline for CoderOutput ..
 // sourcery:inline:CoderOutput.AutoGenerateProtocol
 var android: CoderOutputAndroidProtocol { get }
 var ios: CoderOutputiOSProtocol { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderOutput ✅
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.Android ..
 // sourcery:inline:CoderOutput.Android.AutoGenerateProtocol
 var sourcesFolder: FolderProtocol { get }
 var debug: FileProtocol { get }
 var release: FileProtocol { get }
 var local: FileProtocol? { get }
 var betaRelease: FileProtocol? { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.Android ✅
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.iOS ..
 // sourcery:inline:CoderOutput.iOS.AutoGenerateProtocol
 var sourcesFolder: FolderProtocol { get }
 var xcconfigFile: FileProtocol { get }
 var rnConfigurationModelFactorySwiftFile: FileProtocol { get }
 var infoPlistRNConfiguration: FileProtocol { get }
 var infoPlistRNConfigurationTests: FileProtocol { get }
 var rnConfigurationModelSwiftFile: FileProtocol { get }
 var rnConfigurationBridgeObjectiveCMFile: FileProtocol { get }

 func writeDefaultsToFiles() throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.iOS ✅
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler ..
 // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
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
 // types.implementing.AutoGenerateProtocol inline for PlistWriter ..
 // sourcery:inline:PlistWriter.AutoGenerateProtocol
 static var plistLinesXmlDefault: String { get }
 var output: CoderOutputProtocol { get }
 var sampler: JSONToCodeSamplerProtocol { get }

 func writeRNConfigurationPlist() throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for PlistWriter ✅
 // types.implementing.AutoGenerateProtocol inline for TextFileWriter ..
 // sourcery:inline:TextFileWriter.AutoGenerateProtocol
 static var shared: TextFileWriterProtocol { get }
 var decoder: JSONDecoder { get }

 func writeConfigIfNeeded(from jsonFile: FileProtocol?, for configuration: Configuration, android: FileProtocol?, ios: FileProtocol?) throws
 func writeIOSAndAndroidConfigFiles(from input: CoderInputProtocol, output: CoderOutputProtocol) throws
 func setupCodeSamples(json: JSONEnvironmentProtocol) -> TextFileWriter.Sample
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for TextFileWriter ✅

 // type.annotations.AutoGenerateProtocol for Coder -> See code in the file of that type

 // sourcery:inline:Coder.AutoGenerateProtocol
 var input: CoderInputProtocol { get }
 var output: CoderOutputProtocol { get }
 var codeSampler: JSONToCodeSamplerProtocol { get }
 var signPost: SignPostProtocol { get }
 static var rnConfigurationModelDefault_TOP: String { get }
 static var rnConfigurationModelDefault_BOTTOM: String { get }
 static var factoryTop: String { get }
 static var rnConfigurationModelFactoryProtocolDefault: String { get }

 func attempt() throws  -> CoderOutputProtocol
 func writeRNConfigurationBridge() throws
 func writeRNConfigurationModel() throws
 func writeRNConfigurationModelFactory() throws
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
 */
