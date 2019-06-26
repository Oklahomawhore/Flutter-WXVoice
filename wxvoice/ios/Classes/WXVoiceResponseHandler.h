//
//  WXVoiceResponseHandler.h
//  wxvoice
//
//  Created by Wangshu Zhu on 2019/6/26.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WXVoiceResponseDelegate <NSObject>

@optional

- (void)didReceiveVoiceInputResultArray:(NSArray *)array;

- (void)didReceiveVoiceInputMakeError:(NSInteger)errorCode;

- (void)didReceiveVoiceInputVolumn:(float)volumn;

- (void)didReceiveVoiceInputWaitForResult;

- (void)didReceiveVoiceInputDidCancel;

@end

@interface WXVoiceResponseHandler : NSObject

+ (instancetype)defaultHandler;

- (void)setMethodChannel:(FlutterMethodChannel *)flutterMethodChannel;

@property (nonatomic, assign) id<WXVoiceResponseDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
