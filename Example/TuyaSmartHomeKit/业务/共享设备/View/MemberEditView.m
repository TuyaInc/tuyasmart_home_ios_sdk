//
//  MemberEditView.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "MemberEditView.h"

@interface MemberEditView()

@property(nonatomic,strong) UITextField *usernameTextField;

@end

@implementation MemberEditView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    //用户
    [self addUsernameLabel];
    [self addUsernameView];
    
    //备注
    [self addCommentsLabel];
    [self addCommentsView];
    
    return self;
}

-(void)addUsernameLabel {
    UILabel *nameLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 20, 100, 14) fontSize:14 color:HEXCOLOR(0xB0B0B0)];
    nameLabel.text = NSLocalizedString(@"ty_share_edit_account", @"");
    [self addSubview:nameLabel];
}

-(void)addUsernameView {
    UIView *nameView = [TPViewUtil viewWithFrame:CGRectMake(0, 42, APP_SCREEN_WIDTH, 44) color:[UIColor whiteColor]];
    [nameView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    
    [nameView addSubview:self.usernameTextField];
    
    [nameView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 43.5, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    [self addSubview:nameView];
}

-(void)addCommentsLabel {
    UILabel *phoneLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 108, 100, 14) fontSize:14 color:HEXCOLOR(0xB0B0B0)];
    phoneLabel.text = NSLocalizedString(@"ty_share_edit_alias", @"");
    [self addSubview:phoneLabel];
}

-(void)addCommentsView {
    _commentsView = [TPViewUtil viewWithFrame:CGRectMake(0, 130, APP_SCREEN_WIDTH, 44) color:[UIColor whiteColor]];
    [_commentsView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    
    [_commentsView addSubview:self.commentsTextField];
    
    [_commentsView addSubview:[TPViewUtil viewWithFrame:CGRectMake(0, 43.5, APP_SCREEN_WIDTH, 0.5) color:SEPARATOR_LINE_COLOR]];
    [self addSubview:_commentsView];
}

-(UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [TPViewUtil textFieldWithFrame:CGRectMake(15, 6, APP_SCREEN_WIDTH - 15, 32) fontSize:16 color:HEXCOLOR(0xB0B0B0)];
        _usernameTextField.enabled = NO;
    }
    return _usernameTextField;
}

-(UITextField *)commentsTextField {
    if (!_commentsTextField) {
        _commentsTextField = [TPViewUtil textFieldWithFrame:CGRectMake(15, 6, APP_SCREEN_WIDTH - 15, 32) fontSize:16 color:MAIN_FONT_COLOR];
        _commentsTextField.enabled = NO;
        _commentsTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _commentsTextField;
}

-(NSString *)username {
    return _usernameTextField.text;
}

-(NSString *)comments {
    return _commentsTextField.text;
}

- (void)setup:(TuyaSmartShareMemberModel *)member {
    _usernameTextField.text = member.userName;
    _commentsTextField.text = member.nickName;
}

@end
