//
//  AddNewMemberViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AddNewMemberViewController.h"
#import "AddMemberView.h"
#import "TPSelectCountryViewController.h"
#import "TPViewUtil.h"
#import "TYPeoplePickerController.h"
#import "TYDeviceSharedResultViewController.h"

@interface AddNewMemberViewController () <ATSelectCountryDelegate, TYPeoplePickerControllerDelegate>

@property (nonatomic,strong) AddMemberView      *addMemberView;
@property (nonatomic,strong) TPCountryModel *countryCodeModel;

@property (nonatomic,strong) UIPickerView       *pickerView;
@property (nonatomic,strong) NSArray            *relationshipList;
@property (nonatomic,assign) NSInteger          selectedIndex;
//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;
@property (nonatomic, strong) TYPeoplePickerController *peoplePicker;
@end

@implementation AddNewMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initCountryCode];
}

- (TYPeoplePickerController *)peoplePicker {
    if (!_peoplePicker) {
        _peoplePicker = [TYPeoplePickerController new];
        _peoplePicker.delegate = self;
    }
    return _peoplePicker;
}

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (NSArray *)shareDeviceIds {
    if (!_shareDeviceIds) {
        _shareDeviceIds = [NSArray array];
    }
    return _shareDeviceIds;
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initAddMemberView];
}


- (NSString *)titleForCenterItem {
    return NSLocalizedString(@"new_share", @"");
}



- (void)initAddMemberView {
    _addMemberView = [[AddMemberView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TAB_BAR_HEIGHT)];
    [_addMemberView.countryCodeLabel addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(selectCountryCode)]];
    [_addMemberView.contactBookButton addTarget:self action:@selector(selectContact) forControlEvents:UIControlEventTouchUpInside];
    [_addMemberView.submitButton addTarget:self action:@selector(submitButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addMemberView];
    
    
    if (!IOS8) {
        _addMemberView.contactBookButton.hidden = YES;
    }
}

- (void)selectContact {
    [self.peoplePicker show];
}

- (void)peoplePickerController:(TYPeoplePickerController *)controller didselectCountryModel:(TPCountryModel *)model phoneNumber:(NSString *)phoneNumber {
    
    if (model) {
        [self setCountryCode:model];
    }
    
    _addMemberView.phoneNumberTextField.text = phoneNumber;
}

- (void)initCountryCode {
    TPCountryModel *model = [TPCountryService getCurrentCountryModel];
    
    [self setCountryCode:model];
}

- (void)selectCountryCode {
    TPSelectCountryViewController *selectCountryViewController = [[TPSelectCountryViewController alloc] init];
    selectCountryViewController.delegate = self;
    [self presentViewController:selectCountryViewController animated:YES completion:nil];
}

- (void)setCountryCode:(TPCountryModel *)model {
    _countryCodeModel = model;
    _addMemberView.countryCodeLabel.text = [NSString stringWithFormat:@"%@ +%@", model.countryName, model.countryCode];
}

- (void)submitButtonTap:(UIButton *)button {
   
    
    NSString *userAccount = [_addMemberView phoneNumber];
    [_addMemberView.phoneNumberTextField resignFirstResponder];
    
    if ([userAccount stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        [TPProgressUtils showError:NSLocalizedString(@"username_phone_is_null", @"")];
        return;
    }
    
    WEAKSELF_AT
    [self showProgressView];
    
//    [self.shareService addMemberShare:_countryCodeModel.countryCode userAccount:userAccount devIds:self.shareDeviceIds autoSharing:self.isAutoShare success:^(TuyaSmartShareMemberModel *model) {
//        
//        
//        [weakSelf_AT hideProgressView];
//        [TPNotification postNotificationName:kNotificationMemberUpdate];
//        
//        
//        
//        
//        [weakSelf_AT gotoSharedViewControllerWithError:nil present:(weakSelf_AT.type == 0 ? NO : YES) member:model];
//        
//        
//    } failure:^(NSError *error) {
//        
//        [weakSelf_AT hideProgressView];
//        [weakSelf_AT gotoSharedViewControllerWithError:error present:(weakSelf_AT.type == 0 ? NO : YES) member:nil];
//        
//    }];

}

- (void)gotoSharedViewControllerWithError:(NSError *)error present:(BOOL)presnet member:(TuyaSmartShareMemberModel *)member {
    TYDeviceSharedResultViewController *vc = [[TYDeviceSharedResultViewController alloc] init];
    if (!error) {
        vc.isSuccess = YES;
    } else {
        vc.isSuccess = NO;
        vc.errorInfo = error.localizedDescription;
    }
    vc.isPresent = presnet;
    vc.member = member;
    [self presentViewController:[[TPNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
}


#pragma mark - ATSelectCountryDelegate

- (void)didSelectCountry:(TPSelectCountryViewController *)controller model:(TPCountryModel *)model {
    [self setCountryCode:model];
    [controller tp_dismissModalViewController];
}

@end
