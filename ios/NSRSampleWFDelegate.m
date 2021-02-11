/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "NSRSampleWFDelegate.h"
#import "RNReactNativeIosLibraryNsr.h"

@implementation NSRSampleWFDelegate


-(BOOL)executeLogin:(NSString*)url {
	[[NSUserDefaults standardUserDefaults] setObject:url forKey:@"login_url"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    NSNotification *notification = [NSNotification notificationWithName:@"NSRExecuteLogin" object:@"nsr object" userInfo:@{@"name": @"NSRExecutedLogin", @"url":url}];
    [RNReactNativeIosLibraryNsr emitEventWithName: notification];
    
	return YES;
}

-(NSDictionary*)executePayment:(NSDictionary*)payment url:(NSString*)url {
	[[NSUserDefaults standardUserDefaults] setObject:url forKey:@"payment_url"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    NSNotification *notification = [NSNotification notificationWithName:@"NSRExecutePayment" object:@"nsr object" userInfo:@{@"name": @"NSRExecutedPayment", @"url":url, @"payload": payment}];
    [RNReactNativeIosLibraryNsr emitEventWithName: notification];
	
	return nil;
}

-(void)confirmTransaction:(NSDictionary*)paymentInfo {
    NSNotification *notification = [NSNotification notificationWithName:@"NSRConfirmTransaction" object:@"nsr object" userInfo:@{@"name": @"NSRConfirmedTransaction", @"payload": paymentInfo}];
    [RNReactNativeIosLibraryNsr emitEventWithName: notification];
}

-(void)keepAlive {
    NSLog(@"keepAlive");
}

-(void)goTo:(NSString*)area {
    NSLog(@"goTo: %@", area);
}

@end
