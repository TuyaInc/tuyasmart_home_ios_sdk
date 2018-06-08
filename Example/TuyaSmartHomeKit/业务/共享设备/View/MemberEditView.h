//
//  MemberEditView.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberEditView : UIView

@property(nonatomic,strong) UITextField *commentsTextField;
@property(nonatomic,strong) UIView *commentsView;

- (NSString *)username;
- (NSString *)comments;
- (void)setup:(TuyaSmartShareMemberModel *)member;

@end
