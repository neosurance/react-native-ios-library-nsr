
#import "RNReactNativeIosLibraryNsr.h"

@implementation RNReactNativeIosLibraryNsr

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(greetings: (RCTResponseSenderBlock)callback){
    callback(@[[NSNull null], @"NSR SDK React Native iOS!" ]);
}

@end  
