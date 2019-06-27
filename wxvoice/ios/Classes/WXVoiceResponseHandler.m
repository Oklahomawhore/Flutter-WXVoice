//
//  WXVoiceResponseHandler.m
//  wxvoice
//
//  Created by Wangshu Zhu on 2019/6/26.
//

#import "WXVoiceResponseHandler.h"
#import "WXVoiceRecognizer.h"

@interface WXVoiceResponseHandler () <WXVoiceDelegate>

@end

@implementation WXVoiceResponseHandler

+ (instancetype)defaultHandler {
    static dispatch_once_t onceToken;
    static WXVoiceResponseHandler *singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[WXVoiceResponseHandler alloc] init];
    });
    return singleton;
}

FlutterMethodChannel *flutterWXVoiceMethodChannle = nil;


- (void)setMethodChannel:(id)flutterMethodChannel {
    flutterWXVoiceMethodChannle = flutterMethodChannel;
}

- (void)voiceInputResultArray:(NSArray *)array{
    [flutterWXVoiceMethodChannle invokeMethod:@"voiceInputResultArray" arguments:array];
    
}
- (void)voiceInputMakeError:(NSInteger)errorCode{
    [flutterWXVoiceMethodChannle invokeMethod:@"voiceInputMakeError" arguments:[NSNumber numberWithInteger:errorCode]];
}
- (void)voiceInputVolumn:(float)volumn{
    [flutterWXVoiceMethodChannle invokeMethod:@"voiceInputVolumn" arguments:[NSNumber numberWithFloat:volumn]];
}
- (void)voiceInputWaitForResult{
    NSLog(@"-------------call back voiceInputWaitForResult----------------");
    //    [_speechRecognizerView finishRecorder];
}

- (void)voiceInputDidCancel {
    [flutterWXVoiceMethodChannle invokeMethod:@"voiceInputDidCancel" arguments:nil];
}




@end
