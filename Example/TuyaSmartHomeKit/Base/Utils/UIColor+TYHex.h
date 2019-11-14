//
//  UIColor+TYHex.h
//  TYUIKit
//
//  Created by TuyaInc on 2018/12/17.
//

#import <UIKit/UIKit.h>

/**
 @param hex             RGB like 0x00FF00, or ARGB like 0xFF00FF00
 */
UIKIT_EXTERN UIColor * TY_HexColor(uint32_t hex);

/**
 @param hex             RGB like 0x00FF00
 @param alpha           alpha ∈ [0, 1]
 */
UIKIT_EXTERN UIColor * TY_HexAlphaColor(uint32_t hex, CGFloat alpha);


@interface UIColor (TYHex)

/**
 @param hex             RGB like 0x00FF00, or ARGB like 0xFF00FF00
 */
+ (UIColor *)ty_colorWithHex:(uint32_t)hex;
/**
 @param hex             RGB like 0x00FF00
 @param alpha           alpha ∈ [0, 1]
 */
+ (UIColor *)ty_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

/**
 @param hexStr          RGB like "#00FF00", or ARGB like "#FF00FF00"
 @return return nil if hexStr is illegal
 */
+ (UIColor *)ty_colorWithHexString:(NSString *)hexStr;
/**
 @param hexStr          RGB like "#00FF00"
 @param alpha           alpha ∈ [0, 1]
 @return if hexStr is nil or @"" will return nil
 */
+ (UIColor *)ty_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 @return ARGB hex string like "#FF00FF00"
 */
- (NSString *)ty_ARGBHexString;
/**
 @return RGB hex string like "#00FF00", alpha will be ignore
 */
- (NSString *)ty_RGBHexString;

@end
