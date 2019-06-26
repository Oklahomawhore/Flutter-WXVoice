//
//  WXVoiceResponseHandler.m
//  wxvoice
//
//  Created by Wangshu Zhu on 2019/6/26.
//

#import "WXVoiceResponseHandler.h"
#import "WXVoiceRecognizer.h"

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
    //一旦此方法被回调，array一定会有一个值，所以else的情况不会发生，但写了会更有安全感的
    if ([_delegate respondsToSelector:@selector(didReceiveVoiceInputResultArray:)]) {
        [_delegate didReceiveVoiceInputResultArray:array];
    }
}
- (void)voiceInputMakeError:(NSInteger)errorCode{
    NSLog(@"%ld",(long)errorCode);
    if ([_delegate respondsToSelector:@selector(didReceiveVoiceInputMakeError:)]) {
        [_delegate didReceiveVoiceInputMakeError:errorCode];
    }
}
- (void)voiceInputVolumn:(float)volumn{
    if ([_delegate respondsToSelector:@selector(didReceiveVoiceInputVolumn:)]) {
        [_delegate didReceiveVoiceInputVolumn:volumn];
    }
}
- (void)voiceInputWaitForResult{
    NSLog(@"-------------call back voiceInputWaitForResult----------------");
    //    [_speechRecognizerView finishRecorder];
}
- (void)voiceInputDidCancel{
    if ([_delegate respondsToSelector:@selector(didReceiveVoiceInputDidCancel)]) {
        [_delegate didReceiveVoiceInputDidCancel];
    }
}


@end
