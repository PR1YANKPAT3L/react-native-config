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
    return @{@"BE_BOLIDES_BASE_URL" : @"https://local.armada.bolides.be"};
#else
    return @{@"BE_BOLIDES_BASE_URL" : @"https://staging.armada.bolides.be"};
#endif
#elif RELEASE
    return @{@"BE_BOLIDES_BASE_URL" : @"https://production.armada.bolides.be"};
#elif BETARELEASE
   return @{@"BE_BOLIDES_BASE_URL" : @"https://staging.armada.bolides.be"};
#else
    NSLog(@"⚠️ (react-native-config) ReactNativeConfig.m needs preprocessor macro flag to be set in build settings to RELEASE / DEBUG / LOCAL / BETARELEASE ⚠️");
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
