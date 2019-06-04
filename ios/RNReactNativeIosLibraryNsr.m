
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

RCT_EXPORT_METHOD(setup: (NSString*)jsonSettings : (RCTResponseSenderBlock)callback){
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError* _Nullable error) {}];
        
    }
    
    @try {
        NSMutableDictionary* myarg = [NSJSONSerialization JSONObjectWithData:[jsonSettings dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary* settings = [[NSMutableDictionary alloc] init];
        
        NSString* baseUrl = [myarg valueForKey :@"base_url"];
        NSString* code = [myarg valueForKey :@"code"];
        NSString* secret_key = [myarg valueForKey :@"secret_key"];
        NSString* dev_mode = [myarg valueForKey :@"dev_mode"];
        [settings setObject:baseUrl  forKey:@"base_url"];
        [settings setObject:code forKey:@"code"];
        [settings setObject:secret_key forKey:@"secret_key"];
        [settings setObject:dev_mode forKey:@"dev_mode"];
        
        [settings setObject:[NSNumber numberWithInt:UIStatusBarStyleDefault] forKey:@"bar_style"];
        [settings setObject:[UIColor colorWithRed:0.2 green:1 blue:1 alpha:1] forKey:@"back_color"];
        id res = [NSR sharedInstance];
        [res setup:settings];
        
        NSString* resp = [@"OK SETUP >>> " stringByAppendingString:jsonSettings];
        callback(@[[NSNull null], resp]);
        
    }
    @catch (NSException * e) {
        callback(@[@"ERROR SETUP", [NSNull null] ]);
    }
    
}

RCT_EXPORT_METHOD(refreshFences: (NSString*)jsonArgs : (RCTResponseSenderBlock)callback){
    
    @try {
        NSMutableDictionary* myarg = [NSJSONSerialization JSONObjectWithData:[jsonArgs dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSRUser* user = [[NSRUser alloc] init];
        user.email = [myarg valueForKey :@"email" ];
        user.code = [myarg valueForKey :@"code" ];
        user.firstname = [myarg valueForKey :@"firstname" ];
        user.lastname = [myarg valueForKey :@"lastname" ];
        
        user.mobile = [myarg valueForKey :@"mobile" ];
        user.fiscalCode = [myarg valueForKey :@"fiscalCode" ];
        user.gender = [myarg valueForKey :@"gender" ];
        user.birthday = [myarg valueForKey :@"birthday" ];
        user.address = [myarg valueForKey :@"address" ];
        user.zipCode = [myarg valueForKey :@"zipCode" ];
        user.city = [myarg valueForKey :@"city" ];
        user.stateProvince = [myarg valueForKey :@"stateProvince" ];
        user.country = [myarg valueForKey :@"country" ];
        user.extra = [myarg valueForKey :@"extra" ];
        user.locals = [myarg valueForKey :@"locals" ];
        
        [[NSR sharedInstance] registerUser:user];
        
        NSString* resp = [@"OK REFRESH FENCES >>> " stringByAppendingString:jsonArgs];
        callback(@[[NSNull null], resp]);
        
    }
    @catch (NSException * e) {
        callback(@[@"ERROR REFRESH FENCES", [NSNull null] ]);
    }
    
}

RCT_EXPORT_METHOD(registerUser: (NSString*)jsonUser : (RCTResponseSenderBlock)callback){
    
    @try {
        NSMutableDictionary* myarg = [NSJSONSerialization JSONObjectWithData:[jsonUser dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        
        NSRUser* user = [[NSRUser alloc] init];
        user.email = [myarg valueForKey :@"email" ];
        user.code = [myarg valueForKey :@"code" ];
        user.firstname = [myarg valueForKey :@"firstname" ];
        user.lastname = [myarg valueForKey :@"lastname" ];
        
        user.mobile = [myarg valueForKey :@"mobile" ];
        user.fiscalCode = [myarg valueForKey :@"fiscalCode" ];
        user.gender = [myarg valueForKey :@"gender" ];
        user.birthday = [myarg valueForKey :@"birthday" ];
        user.address = [myarg valueForKey :@"address" ];
        user.zipCode = [myarg valueForKey :@"zipCode" ];
        user.city = [myarg valueForKey :@"city" ];
        user.stateProvince = [myarg valueForKey :@"stateProvince" ];
        user.country = [myarg valueForKey :@"country" ];
        user.extra = [myarg valueForKey :@"extra" ];
        user.locals = [myarg valueForKey :@"locals" ];
        
        [[NSR sharedInstance] registerUser:user];
        
        
        
        NSString* resp = [@"OK REGISTER USER >>> " stringByAppendingString:jsonUser];
        callback(@[[NSNull null], resp]);
        
    }
    @catch (NSException * e) {
        callback(@[@"ERROR REGISTER USER", [NSNull null] ]);
    }
    
}

RCT_EXPORT_METHOD(sendTrialEvent: (NSString*)jsonArgs : (RCTResponseSenderBlock)callback){
    
    @try {
        NSMutableDictionary* myarg = [NSJSONSerialization JSONObjectWithData:[jsonArgs dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        NSString* event = [myarg valueForKey :@"event" ];
        //NSMutableDictionary* payloadTmp = [myarg valueForKey :@"payload" ];
        //[payloadTmp setObject:event forKey:@"what" ];
       
        NSMutableDictionary* payloadTmp = [[NSMutableDictionary alloc] init];
        [payloadTmp setObject:@"1" forKey:@"fake" ];
        
        [[NSR sharedInstance] sendEvent:@"trg1" payload:payloadTmp];
        
        NSString* resp = [@"OK SEND TRIAL EVENT >>> " stringByAppendingString:jsonArgs];
        callback(@[[NSNull null], resp]);
    }
    @catch (NSException * e) {
        callback(@[@"ERROR SEND TRIAL EVENT", [NSNull null] ]);
    }
    
}

RCT_EXPORT_METHOD(showList:(RCTResponseSenderBlock)callback){
    
    @try {
        [[NSR sharedInstance] showApp];
        callback(@[[NSNull null], @"OK SHOW LIST" ]);
    }
    @catch (NSException * e) {
        callback(@[@"ERROR SHOW LIST", [NSNull null] ]);
    }
    
}


@end  
