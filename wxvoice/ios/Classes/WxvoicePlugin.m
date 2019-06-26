#import "WxvoicePlugin.h"
#import "WXVoiceRecognizer.h"
#import "WXVoiceResponseHandler.h"

@implementation WxvoicePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"wxvoice"
                                     binaryMessenger:[registrar messenger]];
    WxvoicePlugin* instance = [[WxvoicePlugin alloc] init];
    [[WXVoiceResponseHandler defaultHandler] setMethodChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"startOneTime" isEqualToString:call.method]) {
        [self startOneTime:call result:result];
        return;
    }
    
    if([@"registerApp" isEqualToString:call.method]) {
        [self registerApp:call result:result];
        return;
    }
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)startOneTime:(FlutterMethodCall*)call result:(FlutterResult)result {
    BOOL success = [[WXVoiceRecognizer sharedWXVoice] startOnce];
    result(@(success));
}

- (void)startContinuous:(FlutterMethodCall*)call result:(FlutterResult)result {
    BOOL yes = [[WXVoiceRecognizer sharedWXVoice] startContinusMode];
    result(@(yes));
}

- (void)finishRecorder:(FlutterMethodCall*)call result:(FlutterResult)result {
    [[WXVoiceRecognizer sharedWXVoice] stopContinusMode];
    result(@YES);
}

- (void)cancel:(FlutterMethodCall*)call result:(FlutterResult)result {
    [[WXVoiceRecognizer sharedWXVoice] cancel];
    result(@YES);
}

- (void)registerApp:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *appId = call.arguments[@"appId"];
    
    WXVoiceRecognizer *speechRecognizer = [WXVoiceRecognizer sharedWXVoice];
    speechRecognizer.silTime = 10.5f;
    
    speechRecognizer.delegate = [WXVoiceResponseHandler defaultHandler];
    [speechRecognizer setAppID:appId];
    [speechRecognizer setDomain:10];
    
    BOOL registered = YES;
    
    result(@YES);
    
    
}

@end
