//
//  TPTextView.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/4/22.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTextView : UITextView

/**
 The string that is displayed when there is no other text in the text view. This property reads and writes the
 attributed variant.
 The default value is `nil`.
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 The attributed string that is displayed when there is no other text in the text view.
 The default value is `nil`.
 */
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

/**
 Returns the drawing rectangle for the text views’s placeholder text.
 @param bounds The bounding rectangle of the receiver.
 @return The computed drawing rectangle for the placeholder text.
 */
- (CGRect)placeholderRectForBounds:(CGRect)bounds;

@end
