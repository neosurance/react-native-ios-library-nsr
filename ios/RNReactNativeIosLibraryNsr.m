
#import "RNReactNativeIosLibraryNsr.h"
#import "NSR.h"

@implementation RNReactNativeIosLibraryNsr

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(greetings: (RCTResponseSenderBlock)callback){
    callback(@[[NSNull null], @"NSR SDK React Native iOS!" ]);
}

- (void)setup{
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError* _Nullable error) {}];
        
    }
    
    @try {
        NSMutableDictionary* settings = [[NSMutableDictionary alloc] init];
        
        NSString* baseUrl = @"https://sandboxng.neosurancecloud.net/api/v1.0/";
        NSString* code = @"bppb";
        NSString* secret_key = @"pass";
        NSString* dev_mode = YES;
        [settings setObject:baseUrl  forKey:@"base_url"];
        [settings setObject:code forKey:@"code"];
        [settings setObject:secret_key forKey:@"secret_key"];
        [settings setObject:dev_mode forKey:@"dev_mode"];
        
        [settings setObject:[NSNumber numberWithInt:UIStatusBarStyleDefault] forKey:@"bar_style"];
        [settings setObject:[UIColor colorWithRed:0.2 green:1 blue:1 alpha:1] forKey:@"back_color"];
        id res = [NSR sharedInstance];
        [res setup:settings];
        
    }
    @catch (NSException * e) {
        
    }
    
}


@end  
