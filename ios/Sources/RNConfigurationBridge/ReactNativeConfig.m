#import "ReactNativeConfig.h"
#import <Foundation/Foundation.h>

@implementation ReactNativeConfig

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSDictionary *)env {
    #ifdef DEBUG
    #ifdef LOCAL
    return @{
            @"example_url" : @"https://local",
    @"exampleBool" : @YES
    };
    #else
    return @{
            @"example_url" : @"https://debug",
    @"exampleBool" : @YES
    };
    #endif
    #elif RELEASE
    return @{
            @"example_url" : @"https://release",
    @"exampleBool" : @YES
    };
    #elif BETARELEASE
    return @{
            @"example_url" : @"https://betaRelease",
    @"exampleBool" : @YES
    };
    #else
        NSLog(@"⚠️ (Coder) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
    return nil;
    #endif
}
+ (NSString *)envFor: (NSString *)key {
    NSString *value = (NSString *)[self.env objectForKey:key];
    return value;
}

- (NSDictionary *)constantsToExport {
    return [ReactNativeConfig env];
}

@end