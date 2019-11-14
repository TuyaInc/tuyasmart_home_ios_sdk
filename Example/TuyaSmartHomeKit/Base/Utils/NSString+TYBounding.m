//
//  NSString+TYBounding.m
//  TYFoundationKit
//
//  Created by TuyaInc on 2019/3/26.
//

#import "NSString+TYBounding.h"

@implementation NSString (TYBounding)

- (CGSize)ty_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)breakMode {
    NSMutableParagraphStyle *paragraphStyle;
    if (breakMode != NSLineBreakByWordWrapping) {
        paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = breakMode;
    }
    return [self ty_boundingSizeWithFont:font constrainedToSize:maxSize paragraphStyle:paragraphStyle];
}

- (CGSize)ty_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize paragraphStyle:(NSParagraphStyle *)paragraphStyle {
    if (!font) {
        return CGSizeZero;
    }
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (paragraphStyle) {
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [self boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    
    return rect.size;
}


- (CGFloat)ty_boundingWidthWithFont:(UIFont *)font {
    CGSize size = [self ty_boundingSizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) paragraphStyle:nil];
    return size.width;
}

- (CGFloat)ty_boundingHeightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth {
    CGSize size = [self ty_boundingSizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) paragraphStyle:nil];
    return size.height;
}


@end
