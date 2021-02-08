
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
        user.cap = [myarg valueForKey :@"zipCode" ];
        user.city = [myarg valueForKey :@"city" ];
        user.province = [myarg valueForKey :@"province" ];
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
        NSMutableDictionary* payloadTmp = [myarg valueForKey :@"payload" ];
        [payloadTmp setObject:event forKey:@"what" ];

        //NSMutableDictionary* payloadTmp = [[NSMutableDictionary alloc] init];
        //[payloadTmp setObject:@"1" forKey:@"fake" ];

        [[NSR sharedInstance] sendEvent:event payload:payloadTmp];

        NSString* resp = [@"OK SEND TRIAL EVENT >>> " stringByAppendingString:jsonArgs];
        callback(@[[NSNull null], resp]);
    }
    @catch (NSException * e) {
        callback(@[@"ERROR SEND TRIAL EVENT", [NSNull null] ]);
    }

}

RCT_EXPORT_METHOD(showApp:(RCTResponseSenderBlock)callback){

    @try {
        [[NSR sharedInstance] showApp];
        callback(@[[NSNull null], @"OK SHOW LIST" ]);
    }
    @catch (NSException * e) {
        callback(@[@"ERROR SHOW LIST", [NSNull null] ]);
    }

}

RCT_EXPORT_METHOD(appLogin:(RCTResponseSenderBlock)callback){

    NSLog(@"AppLogin");
    NSString* url = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_url"];
    if(url != nil){
        [[NSR sharedInstance] loginExecuted:url];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_url"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        callback(@[[NSNull null], @"OK LOGIN EXECUTED: %@",url ]);
    }else
        callback(@[@"ERROR LOGIN EXECUTED", [NSNull null] ]);

}

RCT_EXPORT_METHOD(appPayment:(RCTResponseSenderBlock)callback){

    NSLog(@"AppPayment");
    NSString* url = [[NSUserDefaults standardUserDefaults] objectForKey:@"payment_url"];
    NSMutableDictionary* paymentInfo = [[NSMutableDictionary alloc] init];
    [paymentInfo setObject:@"fakeTransactionCode" forKey:@"transactionCode"];
    [paymentInfo setObject:@"fakeClientIban" forKey:@"iban"];
    if(url != nil){
        [[NSR sharedInstance] paymentExecuted:paymentInfo url:url];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"payment_url"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        callback(@[[NSNull null], @"OK PAYMENT EXECUTED: %@",url]);
    }else
        callback(@[@"ERROR PAYMENT EXECUTED", [NSNull null] ]);

}

RCT_EXPORT_METHOD(policies:(RCTResponseSenderBlock)callback){

    NSLog(@"Policies");
    NSMutableDictionary* criteria = [[NSMutableDictionary alloc] init];
                
    [criteria setObject:[NSNumber numberWithBool:YES] forKey:@"available"];
                
    [[NSR sharedInstance] policies:criteria completionHandler:^(NSDictionary *responseObject, NSError *error) {
        if (error == nil) {
            NSRLog(@"policies response %@", [[NSR sharedInstance] dictToJson:responseObject]);
                        
            NSString* resp = [[NSR sharedInstance] dictToJson:responseObject];
            callback(@[[NSNull null], resp]);
            
        } else {
            NSRLog(@"policies error %@", error);
            callback(@[@"policies error %@", error, [NSNull null] ]);
        }
    }];
    
}

RCT_EXPORT_METHOD(closeView:(RCTResponseSenderBlock)callback){

    NSLog(@"CloseView");
    
    [[NSR sharedInstance] closeView];
    
    callback(@[[NSNull null], @"OK VIEW CLOSED!"]);
    
}


@end
