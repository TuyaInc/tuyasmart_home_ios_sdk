//
//  NSString+TYBounding.h
//  TYFoundationKit
//
//  Created by TuyaInc on 2019/3/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TYBounding)

- (CGSize)ty_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)breakMode;
- (CGSize)ty_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize paragraphStyle:(nullable NSParagraphStyle *)paragraphStyle;

- (CGFloat)ty_boundingWidthWithFont:(UIFont *)font;
- (CGFloat)ty_boundingHeightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
