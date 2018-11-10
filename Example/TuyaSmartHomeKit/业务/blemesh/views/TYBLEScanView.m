//
//  TYBLEScanView.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/20.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYBLEScanView.h"

@implementation TYBLEScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        NSInteger pulsingCount = 3;
        
        double animationDuration = 3;
        
        CALayer * animationLayer = [CALayer layer];
        
        for (int i = 0; i < pulsingCount; i++) {
            CALayer * pulsingLayer = [CALayer layer];
            pulsingLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            pulsingLayer.borderColor = HEXCOLOR(0x5A97FF).CGColor;
            pulsingLayer.borderWidth = 0.5;
            pulsingLayer.cornerRadius = frame.size.height / 2.f;
            
            CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            
            CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
            animationGroup.fillMode = kCAFillModeBackwards;
            animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
            animationGroup.duration = animationDuration;
            animationGroup.repeatCount = HUGE;
            animationGroup.timingFunction = defaultCurve;
            
            
            CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @1;
            scaleAnimation.toValue = @4.2;
            
            CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            opacityAnimation.fromValue = [NSNumber numberWithFloat:0.4];
            opacityAnimation.toValue = [NSNumber numberWithFloat:0];
            
            
            animationGroup.animations = @[scaleAnimation, opacityAnimation];
            [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
            [animationLayer addSublayer:pulsingLayer];
        }
        
        [self.layer addSublayer:animationLayer];
    }
    return self;
}

@end
