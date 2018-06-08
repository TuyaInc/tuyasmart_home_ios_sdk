//
//  TPAnimations.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/3/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPAnimations.h"
#import "TPViewConstants.h"

@implementation TPAnimations


+(void)fadeIn:(UIView *)view
{
    [self fadeIn:view completion:nil];
}

+(void)fadeIn:(UIView *)view completion:(void (^)(BOOL))completion
{
    float duration = 0.3;
    [self fadeIn:view duration:duration completion:completion];
}

+(void)fadeIn:(UIView *)view duration:(float)duration completion:(void (^)(BOOL))completion
{
    view.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)fadeOut:(UIView *)view
{
    [self fadeOut:view completion:nil];
}

+(void)fadeOut:(UIView *)view completion:(void (^)(BOOL))completion
{
    [self fadeOut:view duration:0.3 completion:completion];
}

+(void)fadeOut:(UIView *)view duration:(float)duration completion:(void (^)(BOOL))completion
{
    view.alpha = 1.0;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)pushView:(UIView *)view
{
    [self pushView:view completion:nil];
}

+(void)pushView:(UIView *)view completion:(void (^)(BOOL))completion
{
    CGRect frame = view.frame;
    frame.origin.x = APP_SCREEN_WIDTH;
    view.frame = frame;
    __block CGRect bframe = frame;
    [UIView animateWithDuration:0.3 animations:^{
        bframe.origin.x = 0;
        view.frame = bframe;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)popView:(UIView *)view
{
    [self pushView:view completion:nil];
}

+(void)popView:(UIView *)view completion:(void (^)(BOOL))completion
{
    CGRect frame = view.frame;
    frame.origin.x = 0;
    view.frame = frame;
    __block CGRect bframe = frame;
    [UIView animateWithDuration:0.3 animations:^{
        bframe.origin.x = APP_SCREEN_WIDTH;
        view.frame = bframe;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)presentView:(UIView *)view
{
    [self presentView:view completion:nil];
}

+(void)presentView:(UIView *)view completion:(void (^)(BOOL))completion
{
    CGRect frame = view.frame;
    frame.origin.y = APP_SCREEN_HEIGHT;
    view.frame = frame;
    __block CGRect bframe = frame;
    [UIView animateWithDuration:0.3 animations:^{
        bframe.origin.y = APP_SCREEN_HEIGHT - view.frame.size.height;
        view.frame = bframe;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)dismissModalView:(UIView *)view
{
    [self dismissModalView:view completion:nil];
}

+(void)dismissModalView:(UIView *)view completion:(void (^)(BOOL))completion
{
    CGRect frame = view.frame;
    frame.origin.y = APP_SCREEN_HEIGHT - view.frame.size.height;
    view.frame = frame;
    __block CGRect bframe = frame;
    [UIView animateWithDuration:0.3 animations:^{
        bframe.origin.y = APP_SCREEN_HEIGHT;
        view.frame = bframe;
    } completion:^(BOOL finished) {
        if (completion) completion(finished);
    }];
}

+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance delay:(float)delay
{
    [self verticalMove:view duration:distance distance:distance delay:delay completion:nil];
}

+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance delay:(float)delay completion:(void (^)(BOOL))completion
{
    [self verticalMove:view duration:duration distance:distance options:UIViewAnimationOptionLayoutSubviews delay:delay completion:completion];
}

+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance options:(UIViewAnimationOptions)option delay:(float)delay completion:(void (^)(BOOL))completion
{
    CGRect endFrame = view.frame;
    endFrame.origin.y += distance;
    
    __block UIView *bview = view;
    
    [UIView animateWithDuration:duration delay:delay options:option animations:^{
        bview.frame = endFrame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

+ (void)shake:(UIView *)view distance:(float)distance repeatCount:(NSInteger)repeatCount duration:(float)duration {
    
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    
    
    
    float originY = view.center.y;
    
    NSNumber *number = [NSNumber numberWithFloat:(originY + distance)];
    translation.fromValue = [NSNumber numberWithFloat:originY];
    translation.toValue = number;
    
    translation.duration = duration;
    translation.repeatCount = repeatCount;
    translation.autoreverses = YES;
    
    [view.layer addAnimation:translation forKey:@"positonAnimation"];
    
}


+ (void)photoViewAppearAnimate:(UIView *)view startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame complete:(void (^)(void))complete
{
    view.frame = startFrame;
    CGRect bendFrame = endFrame;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect midFrame = bendFrame;
        if (startFrame.origin.y + startFrame.size.height > endFrame.origin.y + endFrame.size.height)
        {
            midFrame.origin.y -= 10.0;
        }
        else if (startFrame.origin.y > endFrame.origin.y + 10)
        {
            midFrame.origin.y -= 5.0;
        }
        
        if (startFrame.origin.x + startFrame.size.width >= endFrame.origin.x + endFrame.size.width)
        {
            midFrame.origin.x -= 10.0;
        } else {
            midFrame.origin.x -= 5.0;
        }
        
        midFrame.size.width  += 10.0;
        midFrame.size.height += 10.0;
        view.frame = midFrame;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = bendFrame;
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }];
}

+ (void)photoDisappearAnimate:(UIView *)animateView startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame animateTime:(float)animateTime completion:(void (^)(void))completion
{
    animateView.frame = startFrame;
    [UIView animateWithDuration:animateTime
                     animations:^{
                         animateView.frame = endFrame;
                     }
                     completion:^(BOOL finished) {
                         if (completion) completion();
                     }
     ];
}



+(void)TYFadeIn:(UIView *)view {
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:0.3 animations:^{
        view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    } completion:^(BOOL finished) {
        
    }];
}

+(void)TYPresentView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin.y = view.superview.frame.size.height;
    view.frame = frame;
    __block CGRect bframe = frame;
    [UIView animateWithDuration:0.3 animations:^{
        bframe.origin.y = view.superview.frame.size.height - view.frame.size.height;
        view.frame = bframe;
    } completion:^(BOOL finished) {
    }];
}

@end
