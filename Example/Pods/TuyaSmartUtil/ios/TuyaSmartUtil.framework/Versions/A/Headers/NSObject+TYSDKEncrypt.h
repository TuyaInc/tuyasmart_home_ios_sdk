//
//  NSObject+TYEncrypt.h
//  TuyaSmartBaseKit
//
//  Created by 高森 on 2018/6/12.
//

#import <Foundation/Foundation.h>

@interface NSString (TYSDKEnCrypt)

- (NSString *)tysdk_sha1String;

- (NSString *)tysdk_md5String;

- (NSString *)tysdk_sha256String;

- (NSString *)tysdk_aes128EncryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes128DecryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes256EncryptWithKey:(NSString *)key;

- (NSString *)tysdk_aes256DecryptWithKey:(NSString *)key;

- (NSString *)tysdk_hexRSAEncryptWithPublicKey:(NSString *)publicKey;

- (NSString *)tysdk_hexRSANoPaddingEncryptWithPublicKey:(NSString *)publicKey;

- (NSString *)tysdk_hmacSHA256StringWithKey:(NSString *)key;

@end


@interface NSData (TYSDKEncrypt)

- (NSString *)tysdk_md5String;

- (NSString *)tysdk_sha256String;

- (NSData *)tysdk_aes128EncryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes128DecryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes256EncryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_aes256DecryptWithKeyData:(NSData *)keyData;

- (NSData *)tysdk_hmacSHA256DataWithKey:(NSString *)key;

@end
