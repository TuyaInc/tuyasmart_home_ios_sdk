//
//  TYMemberListDelegate.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListDelegate.h"
#import "MemberEditViewController.h"
#import "AddDeviceListViewController.h"

@interface TYMemberListDelegate()

//@property (nonatomic, strong) TuyaSmartDeviceShare *shareService;

@end

@implementation TYMemberListDelegate

//- (TuyaSmartDeviceShare *)shareService {
//    if (!_shareService) {
//        _shareService = [[TuyaSmartDeviceShare alloc] init];
//    }
//    return _shareService;
//}

- (void)memberListView:(TYMemberListView *)memberListView didSelectRowAtModel:(TuyaSmartShareMemberModel *)member currentType:(TYMemberCurrentType)currentType indexPath:(NSIndexPath *)indexPath {
    
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    if (currentType == TYMemberSend) {
        
//        [self.shareService getShareMemberDetail:member.memberId success:^(TuyaSmartShareMemberDetailModel *model) {
//
//            MemberEditViewController *editViewController = [[MemberEditViewController alloc] init];
//            editViewController.member = member;
//            editViewController.type = 0;
//            editViewController.isAutoShare = model.autoSharing;
//            editViewController.shareDeviceList = model.devices;
//
//            [tp_topMostViewController().navigationController pushViewController:editViewController animated:YES];
//            [TPProgressUtils hideHUDForView:nil animated:YES];
//
//
//        } failure:^(NSError *error) {
//
//            [TPProgressUtils hideHUDForView:nil animated:YES];
//
//
//        }];
        

    } else {
        
//        [self.shareService getReceiveMemberDetail:member.memberId success:^(TuyaSmartReceiveMemberDetailModel *model) {
//
//
//
//            MemberEditViewController *editViewController = [[MemberEditViewController alloc] init];
//            editViewController.member = member;
//            editViewController.type = 1;
//            editViewController.receiveDeviceList = model.devices;
//
//            [tp_topMostViewController().navigationController pushViewController:editViewController animated:YES];
//            [TPProgressUtils hideHUDForView:nil animated:YES];
//
//
//        } failure:^(NSError *error) {
//            [TPProgressUtils hideHUDForView:nil animated:YES];
//        }];
        
    }
}

- (void)memberListView:(TYMemberListView *)memberListView deleteRowWithMember:(TuyaSmartShareMemberModel *)member currentType:(TYMemberCurrentType)currentType success:(TYSuccessHandler)success failure:(TYFailureError)failure {
    if (currentType == TYMemberSend) {
//        [self.shareService removeShareMember:member.memberId success:^() {
//            if (success) success();
//            [[TuyaSmartUser sharedInstance] syncDeviceWithCloud:nil failure:nil];
//        } failure:^(NSError *error) {
//            if (failure) failure(error);
//        }];
    } else {
//        [self.shareService removeReceiveMember:member.memberId success:^() {
//            if (success) success();
//            [[TuyaSmartUser sharedInstance] syncDeviceWithCloud:nil failure:nil];
//        } failure:^(NSError *error) {
//            if (failure) failure(error);
//        }];
    }
}

- (void)addNewMember:(TYMemberListView *)memberListView {
    AddDeviceListViewController *vc = [[AddDeviceListViewController alloc] init];
    TPNavigationController *navi = [[TPNavigationController alloc] initWithRootViewController:vc];
    [tp_topMostViewController().navigationController presentViewController:navi animated:YES completion:nil];
}

@end
