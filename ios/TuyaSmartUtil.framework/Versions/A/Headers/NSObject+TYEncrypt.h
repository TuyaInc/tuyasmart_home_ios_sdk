//
//  NSObject+TYEncrypt.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYCrypto)

- (NSString *)ty_sha1String;

- (NSString *)ty_md5String;

@end


@interface NSData (TYCrypto)

- (NSString *)ty_md5String;

- (NSData *)ty_aes128EncryptWithKey:(NSString *)key;

- (NSData *)ty_aes128DecryptWithKey:(NSString *)key;

@end
