#import "ReactNativeConfig.h"

@implementation ReactNativeConfig

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSDictionary *)env {
    // TODO add variables via script with debug flag
    
   // return [RNConfigurationModelFactory allValuesDictionaryAndReturnError:nil];
    return nil;
}

+ (NSString *)envFor: (NSString *)key {
    NSString *value = (NSString *)[self.env objectForKey:key];
    return value;
}

- (NSDictionary *)constantsToExport {
    return [ReactNativeConfig env];
}

@end
