#import "ReactNativeConfig.h"
#import <ReactNativeConfigSwift/ReactNativeConfigSwift-Swift.h>


@implementation ReactNativeConfig

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

+ (NSDictionary *)env {
    return [CurrentBuildConfigurationWorker allValuesDictionaryAndReturnError:nil];
}

+ (NSString *)envFor: (NSString *)key {
    NSString *value = (NSString *)[self.env objectForKey:key];
    return value;
}

- (NSDictionary *)constantsToExport {
    return [CurrentBuildConfigurationWorker allValuesDictionaryAndReturnError:nil];
}

@end
