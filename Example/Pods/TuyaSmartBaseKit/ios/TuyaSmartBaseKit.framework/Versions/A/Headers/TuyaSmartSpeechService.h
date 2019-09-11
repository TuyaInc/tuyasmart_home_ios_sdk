//
//  TuyaSpeechService.h
//  TuyaSmartBaseKit-iOS
//
//  Created by Kennaki Kai on 2019/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSpeechService : NSObject

/**
 audio data convert to text
 音频转为文字

 @param audioData   audio data
 @param audioRate   audio rate
 @param audioType   audio type
 @param homeId      home id
 @param success     Success block (audio text)
 @param failure     Failure block
 */
- (void)convertToTextWithAudioData:(NSData *)audioData
                         audioRate:(NSString *)audioRate
                         audioType:(NSString *)audioType
                            homeId:(long long)homeId
                           success:(nullable TYSuccessString)success
                           failure:(nullable TYFailureError)failure;

/**
 execute voice command
 执行音频命令
 
 @param speechText  Voice text
 @param homeId      home id
 @param success     Success block (dictionary contains command result and if need to keep session)
 @param failure     Failure block
 */
- (void)executeCommandWithSpeechText:(NSString *)speechText
                              homeId:(long long)homeId
                             success:(nullable TYSuccessDict)success
                             failure:(nullable TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
