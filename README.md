# Config variables for React Native apps 
>Test - Integrate - Build status: [@dooZ ![Build Status](https://app.bitrise.io/app/238dadb7a4dc2be7/status.svg?token=KT-GNKvst7k7TaqHzCWX-g)](https://app.bitrise.io/app/238dadb7a4dc2be7) [@Bolides ![Build Status](https://app.bitrise.io/app/4eb10fc93f53e066/status.svg?token=8p8AGiR7wGvwyO6Y-HGStw)](https://app.bitrise.io/app/4eb10fc93f53e066)

Module to expose config variables to your javascript code in React Native, supporting both iOS (Objective-C & Swift) and Android.

Bring some [12 factor](http://12factor.net/config) love to your mobile apps!

Run this before building

``` bash
 swift build --product RNConfigurationHighwaySetup -c release --static-swift-stdlib
./.build/x86_64-apple-macosx10.10/release/RNConfigurationHighwaySetup -path $PATH noGithooksPrePush
```
Run tests

``` bash
cd <#react native root folder#>
# run test so you are sure all file changed to the expected value for the configuration you set next
./.build/x86_64-apple-macosx10.10/release/RNConfigurationHighwaySetup -path $PATH noGithooksPrePush <#configuration#>
swift test
```
more info about the misterious `<#configuration#> below.

## Basic Usage

Create a new file `.env.<#configuration#>.json` (release and debug are required) in the root of your React Native app:

```
{
    "typed": {
        "url": {
            "value": "https://debug",
            "valueType": "Url"
        }
    },
    "booleans": {
        "exampleBool": true
    }
}
```

Then access variables defined there from your app:


```js
import Config from 'react-native-config'

Config.<#key#> 
```

Keep in mind this module doesn't obfuscate or encrypt secrets for packaging, so **do not store sensitive keys in `.env`**. 

It's [basically impossible to prevent users from reverse engineering mobile app secrets](https://rammic.github.io/2015/07/28/hiding-secrets-in-android-apps/), so design your app (and APIs) with that in mind.

// TODO: add secret keys in both android and iOS that are stored using git_secret and secure storage for both Android and iOS to solve issue above [github issue #1](https://github.com/doozMen/react-native-config/issues/1)

## Integrate in React Native

Install the package:

Unfortunatly I did not get anything to work with npm install package.json. Tips are welcome. The known workaround is

```
cd <#project root#>
npm install
touch Cartfile
# add github "Bolide/react-native-config" ~> <#version#> # anything up from 1.5 should work
carthage update --

# If you need to prepare more like the Expo staging and production environment you can use RNModels, RNConfiguration and RNConfigurationPrepare in a swift executable
swift package init
# add to Package.swift .package(url: "https://www.github.com/Bolides/react-native-config", "1.5.0" ..< "2.0.0")
swift package update
swift package generate-xcodeproj
# the project step is optional and you do not need the xcode project so can ignore it in git if you want
```

> Find info about Carhage on github `Carthage/Carthage`

> ⚠️ Only works for project that use expokit and ejected the project


# iOS

In xcode project

1. Add project as a sub project and add product `RNModels` & `RNConfiguarion` to embed frameworks
2. Add `RNConfigurationBridge.a` static library link to project target
2. Point framework search path to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)`
3. Point header search path to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)/include` and set it to **recursive**
4. Point library search path to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)`

Before you build you should run 

```bash 
# go to folder where env.<#configuration#>.json files are
cd <#react native root folder#>
./.build/x86_64-apple-macosx10.10/release/RNConfigurationHighwaySetup -path $PATH noGithooksPrePush <#configuration#>
```
**configuration** is the thing you use in xcode scheme to build. Make sure you run the script before building for the first time in that configuration.

> ⚠️ For every configuration change or `env.<#configuration#>.json`  files change run script again for the changed <#configuration#>

### Extra step for Android

You'll also need to manually apply a plugin to your app, from `android/app/build.gradle`:

```
// 2nd line, add a new apply:
apply from: project(':react-native-config').projectDir.getPath() + "/dotenv.gradle"
```


#### Advanced Android Setup

In `android/app/build.gradle`, if you use `applicationIdSuffix` or `applicationId` that is different from the package name indicated in `AndroidManifest.xml` in `<manifest package="...">` tag, for example, to support different build variants:
Add this in `android/app/build.gradle`

```
defaultConfig {
    ...
    resValue "string", "build_config_package", "YOUR_PACKAGE_NAME_IN_ANDROIDMANIFEST.XML"
}
```

## Native Usage

### Android

Config variables set in `.env` are available to your Java classes via `BuildConfig`:

```java
public HttpURLConnection getApiClient() {
    URL url = new URL(BuildConfig.API_URL);
    // ...
}
```

You can also read them from your Gradle configuration:

```groovy
defaultConfig {
    applicationId project.env.get("APP_ID")
}
```

And use them to configure libraries in `AndroidManifest.xml` and others:

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="@string/GOOGLE_MAPS_API_KEY" />
```

All variables are strings, so you may need to cast them. For instance, in Gradle:

```
versionCode project.env.get("VERSION_CODE").toInteger()
```

Once again, remember variables stored in `.env` are published with your code, so **DO NOT put anything sensitive there like your app `signingConfigs`.**

### iOS

#### Swift

``` swift
import ReactNativeConfigSwift

let environmentPlist = try Environment.plist()
print(environmentPlist)
```
#### Objective-C
Read variables declared in `.env` from your Obj-C classes like:

```objective-c
// import header
#import "ReactNativeConfig.h"

// then read individual keys like:
NSString *apiUrl = [ReactNativeConfig envFor:@"API_URL"];

// or just fetch the whole config
NSDictionary *config = [ReactNativeConfig env];
```

### Different environments

Save config for different environments in different files: `.env.staging.json`, `.env.production.json`, etc.

#### JS

To make sure it works you should 
```
$ ENVFILE=.env.staging react-native run-ios           # bash
$ SET ENVFILE=.env.staging && react-native run-ios    # windows
$ env:ENVFILE=".env.staging"; react-native run-ios    # powershell
```

This also works for `run-android`. Alternatively, there are platform-specific options below.


#### Android

The same environment variable can be used to assemble releases with a different config:

```
$ cd android && ENVFILE=.env.staging ./gradlew assembleRelease
```

Alternatively, you can define a map in `build.gradle` associating builds with env files. Do it before the `apply from` call, and use build cases in lowercase, like:

```
project.ext.envConfigFiles = [
    debug: ".env.development",
    release: ".env.production",
    anothercustombuild: ".env",
]

apply from: project(':react-native-config').projectDir.getPath() + "/dotenv.gradle"
```


#### iOS
If you use `debug`, `local` and `release` configurations there is nothing more to do. If you do you need to for this repo and add your config.


## Troubleshooting

### Problems with Proguard

When Proguard is enabled (which it is by default for Android release builds), it can rename the `BuildConfig` Java class in the minification process and prevent React Native Config from referencing it. To avoid this, add an exception to `android/app/proguard-rules.pro`:

    -keep class com.mypackage.BuildConfig { *; }
    
`mypackage` should match the `package` value in your `app/src/main/AndroidManifest.xml` file.

---
---

---
# Background
---

What does it do

1. It reads the `env.<#configuration#>.json` files and creates config files for ios and android
2. xconfig file used by `RNConfiguration.framework` and env.<#configuration#> files used by android
2. Puts generated swift code in `RNConfiguration` framework in `RNConfigurationModel.swift` and `RNConfigurationModelFactory.swift`. These files get overriden so do not change them
3. Puts c-code in `RNConfigurationBride` to be able to use the keys and values in Javascript
4. Uses the react native bridge imports of your project. So to be able to build it you need to integrate and build your react native project first so it find sthe `"RCTBridgeModule.h"`
