//
//  TYSearchDeviceFinishView.h
//  TuyaSmart
//
//  Created by 高森 on 16/1/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

@class TYSearchDeviceFinishView;

@protocol TYSearchDeviceFinishDelegate <NSObject>

@required

- (void)helpAction:(TYSearchDeviceFinishView *)finishView;
- (void)retryAction:(TYSearchDeviceFinishView *)finishView;
- (void)callAction:(TYSearchDeviceFinishView *)finishView;

- (void)shareAction:(TYSearchDeviceFinishView *)finishView;
- (void)doneAction:(TYSearchDeviceFinishView *)finishView deviceModel:(TuyaSmartDeviceModel *)deviceModel;

@end

@interface TYSearchDeviceFinishView : UIView

@property (nonatomic, weak) id <TYSearchDeviceFinishDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame isSuccess:(BOOL)isSuccess device:(TuyaSmartDeviceModel *)deviceModel;

@end
