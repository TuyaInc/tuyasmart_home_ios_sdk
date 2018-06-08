//
//  TPInputPhoneView.h
//  fishNurse
//
//  Created by 高森 on 16/2/23.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"

@class TPInputUserAccountView;

@protocol TPInputPhoneViewDelegate <NSObject>

- (void)inputPhoneViewCountrySelectViewTap:(TPInputUserAccountView *)inputPhoneView;
- (void)inputPhoneViewNextButtonTap:(TPInputUserAccountView *)inputPhoneView;

@end

@interface TPInputUserAccountView : TPBaseLayout

@property (nonatomic, weak) id<TPInputPhoneViewDelegate> delegate;

@property (nonatomic, strong) NSString *userAccount;

- (void)setCountryCode:(TPCountryModel *)countryCodeModel;

@end
