//
//  AddMemberView.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/2.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMemberView : UIView

@property(nonatomic,strong) UILabel *countryCodeLabel;
@property(nonatomic,strong) UITextField *phoneNumberTextField;
@property(nonatomic,strong) UIButton *contactBookButton;
@property(nonatomic,strong) UIButton *submitButton;

-(NSString *)phoneNumber;

@end
