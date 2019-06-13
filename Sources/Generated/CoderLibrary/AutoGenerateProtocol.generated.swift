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

 // types.implementing.AutoGenerateProtocol inline for Coder ..
 // sourcery:inline:Coder.AutoGenerateProtocol
 static var rnConfigurationModelDefault_TOP: String { get }
 static var rnConfigurationModelDefault_BOTTOM: String { get }
 static var factoryTop: String { get }
 static var rnConfigurationModelFactoryProtocolDefault: String { get }

 func attemptCode(to output: CoderOutputProtocol) throws  -> CoderOutputProtocol
 func writeRNConfigurationModel(to output: CoderOutputProtocol) throws
 func writeRNConfigurationModelFactory(to output: CoderOutputProtocol) throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for Coder ✅
 // types.implementing.AutoGenerateProtocol inline for CoderOutput ..
 // sourcery:inline:CoderOutput.AutoGenerateProtocol
 var android: CoderOutputAndroidProtocol { get }
 var ios: CoderOutputiOSProtocol { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderOutput ✅
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.Android ..
 // sourcery:inline:CoderOutput.Android.AutoGenerateProtocol
 var sourcesFolder: FolderProtocol { get }
 var configFiles: [RNModels.Configuration: FileProtocol] { get }

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
 var jsBridge: FileProtocol { get }

 func writeDefaultsToFiles() throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for CoderOutput.iOS ✅
 // types.implementing.AutoGenerateProtocol inline for Copy ..
 // sourcery:inline:Copy.AutoGenerateProtocol

 func attempt(to yourSrcRoot: FolderProtocol, copyToFolderName: String) throws  -> FolderProtocol
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for Copy ✅
 // types.implementing.AutoGenerateProtocol inline for JSBridgeCodeSample ..
 // sourcery:inline:JSBridgeCodeSample.AutoGenerateProtocol

 func writeRNConfigurationBridge(to file: FileProtocol, sampler: JSONToCodeSamplerProtocol) throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for JSBridgeCodeSample ✅
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler ..
 // sourcery:inline:JSONToCodeSampler.AutoGenerateProtocol
 var jsonEnvironments: JSONEnvironmentsProtocol { get }
 var casesForEnum: String { get }
 var configurationModelVar: String { get }
 var configurationModelVarDescription: String { get }
 var plistLinesXmlText: String { get }
 var decoderInit: String { get }
 var bridgeEnv: [RNModels.Configuration: [String]] { get }

 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for JSONToCodeSampler ✅
 // types.implementing.AutoGenerateProtocol inline for PlistWriter ..
 // sourcery:inline:PlistWriter.AutoGenerateProtocol
 static var plistLinesXmlDefault: String { get }

 func writeRNConfigurationPlist(output: CoderOutputProtocol, sampler: JSONToCodeSamplerProtocol) throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for PlistWriter ✅
 // types.implementing.AutoGenerateProtocol inline for TextFileWriter ..
 // sourcery:inline:TextFileWriter.AutoGenerateProtocol
 static var shared: TextFileWriterProtocol { get }
 var decoder: JSONDecoder { get }

 func writeIOSAndAndroidConfigFiles(from json: JSONEnvironmentsProtocol, output: CoderOutputProtocol) throws
 // sourcery:end
 // types.implementing.AutoGenerateProtocol inline for TextFileWriter ✅

 */
