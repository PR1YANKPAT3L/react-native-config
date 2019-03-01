#import "ReactNativeConfig.h"
#import <RNConfiguration/RNConfiguration-Swift.h>

@implementation ReactNativeConfig

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSDictionary *)env {
    return [RNConfigurationModelFactory allValuesDictionaryAndReturnError:nil];
}

+ (NSString *)envFor: (NSString *)key {
    NSString *value = (NSString *)[self.env objectForKey:key];
    return value;
}

- (NSDictionary *)constantsToExport {
    return [RNConfigurationModelFactory allValuesDictionaryAndReturnError:nil];
}

@end
