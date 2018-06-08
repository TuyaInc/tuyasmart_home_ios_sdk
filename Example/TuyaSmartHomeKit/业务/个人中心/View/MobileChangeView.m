//
//  MobileChangeView.m
//  TuyaSmartPublic
//
//  Created by remy on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "MobileChangeView.h"

@interface MobileChangeView()

@end

@implementation MobileChangeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        self.topBarView.centerItem.title = NSLocalizedString(@"mobile_binding", @"");
        [self addSubview:self.topBarView];
        
        UIImageView *phone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ty_me_mobile_phone"]];
        phone.top = APP_TOP_BAR_HEIGHT + 80;
        phone.left = (APP_CONTENT_WIDTH - phone.width) / 2;
        [self addSubview:phone];
        
        _title = [TPViewUtil labelWithFrame:CGRectMake(0, phone.bottom + 40, APP_CONTENT_WIDTH, 22) fontSize:16 color:LIST_MAIN_TEXT_COLOR];
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
        
        UILabel *desc = [TPViewUtil labelWithFrame:CGRectMake(0, _title.bottom + 8, APP_CONTENT_WIDTH, 20) fontSize:14 color:LIST_SUB_TEXT_COLOR];
        desc.textAlignment = NSTextAlignmentCenter;
        desc.text = NSLocalizedString(@"ty_mobile_change_tip", @"");
        [self addSubview:desc];
        
        _changeButton = [TPViewUtil buttonWithFrame:CGRectMake(15, desc.bottom + 43, self.width - 30, 44) fontSize:16 bgColor:BUTTON_BACKGROUND_COLOR textColor:BUTTON_TEXT_COLOR borderColor:nil];
        [_changeButton setTitle:NSLocalizedString(@"ty_mobile_change_button", @"") forState:UIControlStateNormal];
        [self addSubview:_changeButton];
    }
    return self;
}

@end
